import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_degrees_worker_model.dart';

class EmpDegreesWorkerRepository {
  final ApiService _apiService;

  EmpDegreesWorkerRepository(this._apiService);

  Future<Either<Failure, List<EmpDegreesWorkerModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllEmpDegreesWorker();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDegreesWorkerModel>> save(
      EmpDegreesWorkerModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpDegreesWorker(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDegreesWorkerModel>> update(
      int id, EmpDegreesWorkerModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpDegreesWorker(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpDegreesWorker(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
