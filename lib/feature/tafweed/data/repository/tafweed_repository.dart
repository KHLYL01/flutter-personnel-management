import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/tafweed_model.dart';

class TafweedRepository {
  final ApiService _apiService;

  TafweedRepository(this._apiService);

  Future<Either<Failure, List<TafweedSearchModel>>> search({
    required int empId,
  }) async {
    try {
      final httpResponse = await _apiService.searchTafweed(empId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, TafweedModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findTafweedById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, TafweedModel>> save(TafweedModel model) async {
    try {
      final httpResponse = await _apiService.saveTafweed(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, TafweedModel>> update(
      int id, TafweedModel model) async {
    try {
      final httpResponse = await _apiService.updateTafweed(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteTafweed(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
