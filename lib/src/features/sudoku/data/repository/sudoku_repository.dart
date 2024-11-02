import 'package:dio/dio.dart';
import 'package:flutter_games/src/core/network/error/dio_error_handler.dart';
import 'package:flutter_games/src/core/utils/constants/api_config.dart';

import '../../../../core/network/error/exceptions.dart';
import '../model/sudoku.dart';

class SudokuRepository {
  final Dio dio;

  CancelToken cancelToken = CancelToken();
  SudokuRepository(this.dio);

  Future<Sudoku?> generateSudoku() async {
    try {
      var response = await dio.get(
        APIEndpoint.sudokuGenerator,
      );
      if (response.statusCode == 200) {
        return Sudoku.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
    return null;
  }

  Future<Map<String, dynamic>> verifySudoku(String sudokuData) async {
    try {
      var response = await dio.get(
        APIEndpoint.sudokuVerifier,
        queryParameters: {"task": sudokuData},
      );
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) {
        throw CancelTokenException(handleDioError(e), e.response?.statusCode);
      } else {
        throw ServerException(handleDioError(e), e.response?.statusCode);
      }
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString(), null);
    }
    return {};
  }
}
