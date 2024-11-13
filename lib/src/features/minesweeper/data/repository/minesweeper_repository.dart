import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_games/src/core/network/error/dio_error_handler.dart';
import 'package:flutter_games/src/core/utils/constants/api_config.dart';

import '../../../../core/network/error/exceptions.dart';
import '../model/minesweeper_model.dart';

class MineSweeperRepository {
  MineSweeperRepository(this.dio);

  CancelToken cancelToken = CancelToken();
  final Dio dio;

  Future<MineData?> generateMinesweeper({
    int width = 8,
    int height = 8,
    int mines = 10,
  }) async {
    try {
      var response =
          await dio.get(APIEndpoint.mineSweeperGenerator, queryParameters: {
        'start':
            "${(1 + Random().nextInt(width - 1 + 1))}-${(1 + Random().nextInt(width - 1 + 1))}",
        'width': width.toString(),
        'height': height.toString(),
        'mines': mines.toString(),
      });
      if (response.statusCode == 200) {
        return MineData.fromJson(response.data);
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
}
