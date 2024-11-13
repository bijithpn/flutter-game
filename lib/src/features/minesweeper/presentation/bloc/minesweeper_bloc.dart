import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_games/src/core/helper/minesweeper_helper.dart';
import 'package:flutter_games/src/core/network/error/dio_error_handler.dart';
import 'package:flutter_games/src/core/network/error/exceptions.dart';
import 'package:flutter_games/src/features/minesweeper/data/model/minesweeper_model.dart';
import 'package:flutter_games/src/features/minesweeper/data/repository/minesweeper_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'minesweeper_event.dart';
part 'minesweeper_state.dart';

class MinesweeperBloc extends HydratedBloc<MinesweeperEvent, MinesweeperState> {
  MinesweeperBloc(this.mineSweeperRepository) : super(MinesweeperInitial()) {
    on<MinesweeperGenerateEvent>(_onGenerateMinesweeper,
        transformer: restartable());
    on<MinesweeperCellTappedEvent>(_onTapCell);
    on<MinesweeperResetEvent>(_onResetMinesweeper);
  }

  final MineSweeperRepository mineSweeperRepository;

  MineData? _currentPuzzle;

  @override
  MinesweeperState? fromJson(Map<String, dynamic> json) {
    try {
      final mines = MineData.fromJson(json['currentPuzzle']);
      _currentPuzzle = mines;
      return MinesweeperGenerated(minesweeper: mines);
    } catch (e) {
      return MinesweeperInitial();
    }
  }

  @override
  Map<String, dynamic>? toJson(MinesweeperState state) {
    if (state is MinesweeperGenerated) {
      return {'currentPuzzle': state.minesweeper.toJson()};
    }
    return null;
  }

  Future<void> _onGenerateMinesweeper(
      MinesweeperGenerateEvent event, Emitter<MinesweeperState> emit) async {
    try {
      if (!event.initiaLunch && _currentPuzzle != null) {
        emit(MinesweeperGenerated(minesweeper: _currentPuzzle!));
        return;
      }
      emit(MinesweeperLoading());
      var result = await mineSweeperRepository.generateMinesweeper(
        width: event.boardWidth,
        height: event.boardHeight,
        mines: event.mineCount,
      );
      if (result != null) {
        _currentPuzzle = result;
        emit(MinesweeperGenerated(minesweeper: _currentPuzzle!));
      }
    } on DioException catch (e) {
      emit(MinesweeperError(message: handleDioError(e)));
    } on ServerException {
      emit(MinesweeperError(
          message: "There seems to be an issue connecting to the server"));
    } catch (e) {
      emit(MinesweeperError(message: e.toString()));
    }
  }

  Future<void> _onResetMinesweeper(
      MinesweeperResetEvent event, Emitter<MinesweeperState> emit) async {
    try {
      emit(MinesweeperLoading());
      var result = await mineSweeperRepository.generateMinesweeper();
      if (result != null) {
        _currentPuzzle = result;
        emit(MinesweeperGenerated(minesweeper: _currentPuzzle!));
      }
    } on DioException catch (e) {
      emit(MinesweeperError(message: handleDioError(e)));
    } on ServerException {
      emit(MinesweeperError(
          message: "There seems to be an issue connecting to the server"));
    } catch (e) {
      emit(MinesweeperError(message: e.toString()));
    }
  }

  void _onTapCell(
      MinesweeperCellTappedEvent event, Emitter<MinesweeperState> emit) {
    if (_currentPuzzle != null) {
      List<List<Cell>> newBoard = _currentPuzzle!.board.map((row) {
        return row.map((cell) => cell).toList();
      }).toList();
      if (event.isFlagged) {
        newBoard[event.row][event.column].cellState = CellState.flagged;
      } else if (!newBoard[event.row][event.column].hasMine &&
          newBoard[event.row][event.column].cellState == CellState.hidden) {
        newBoard[event.row][event.column].cellState = CellState.revealed;
        if (newBoard[event.row][event.column].adjacentMines == 0) {
          newBoard = MinesweeperHelper.getAdjacentValues(
              newBoard, event.row, event.column);
        }
        if (MinesweeperHelper.isGameWon(
            board: newBoard,
            mineCount: _currentPuzzle!.mines,
            cellSize: _currentPuzzle!.width)) {
          emit(GameWon());
        }
      } else if (newBoard[event.row][event.column].hasMine &&
          newBoard[event.row][event.column].cellState != CellState.flagged) {
        emit(GameOver(
          cellSize: _currentPuzzle?.width ?? 8,
          board: MinesweeperHelper.revealMines(
              _currentPuzzle?.width ?? 8, _currentPuzzle!.board),
        ));
        return;
      }
      final updatedPuzzle = _currentPuzzle!.copyWith(board: newBoard);
      _currentPuzzle = updatedPuzzle;
      emit(MinesweeperGenerated(minesweeper: updatedPuzzle));
    }
  }
}
