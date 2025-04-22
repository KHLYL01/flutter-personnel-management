import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/employee_model.dart';

class EmployeeRepository {
  final ApiService _apiService;

  EmployeeRepository(this._apiService);

  Future<Either<Failure, List<EmployeeSearchModel>>> search({
    required int? id,
    required String? name,
    required String? cardId,
    required int? jobId,
    required int? partId,
    required String? fia,
    required double? draga,
    required String? jobState,
    required String? empType,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmployee(
          id, name, cardId, jobId, partId, fia, draga, jobState, empType);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmployeeFindModel>>> find({
    required int? id,
    required String? name,
    required String? cardId,
    required String? empType,
  }) async {
    try {
      final httpResponse =
          await _apiService.findEmployee(id, name, cardId, empType);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmployeeModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmployeeById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmployeeModel>> save(EmployeeModel model) async {
    try {
      final httpResponse = await _apiService.saveEmployee(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmployeeModel>> update(
      int id, EmployeeModel model) async {
    try {
      final httpResponse = await _apiService.updateEmployee(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmployee(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
