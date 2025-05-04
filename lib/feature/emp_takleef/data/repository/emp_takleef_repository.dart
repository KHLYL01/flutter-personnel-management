import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_takleef_model.dart';

class EmpTakleefRepository {
  final ApiService _apiService;

  EmpTakleefRepository(this._apiService);

  Future<Either<Failure, List<EmpTakleefSearchModel>>> search({
    required String name,
    required String cardId,
    required String place,
  }) async {
    try {
      final httpResponse =
          await _apiService.searchEmpTakleef(name, cardId, place);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTakleefModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpTakleefById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTakleefModel>> save(EmpTakleefModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpTakleef(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTakleefModel>> update(
      int id, EmpTakleefModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpTakleef(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpTakleef(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
