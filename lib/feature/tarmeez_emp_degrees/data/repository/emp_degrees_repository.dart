import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_degrees_model.dart';

class EmpDegreesRepository {
  final ApiService _apiService;

  EmpDegreesRepository(this._apiService);

  Future<Either<Failure, List<EmpDegreesModel>>> find({
    required double? martaba,
    required double? draga,
  }) async {
    try {
      final httpResponse = await _apiService.findDegrees(martaba, draga);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpDegreesModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllEmpDegrees();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDegreesModel>> save(EmpDegreesModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpDegrees(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDegreesModel>> update(
      int id, EmpDegreesModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpDegrees(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpDegrees(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
