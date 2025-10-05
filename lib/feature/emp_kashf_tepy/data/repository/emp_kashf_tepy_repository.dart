import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_kashf_tepy_model.dart';

class EmpKashfTepyRepository {
  final ApiService _apiService;

  EmpKashfTepyRepository(this._apiService);

  Future<Either<Failure, List<EmpKashfTepySearchModel>>> search({
    required String name,
    required String cardId,
    required String empType,
  }) async {
    try {
      final httpResponse =
          await _apiService.searchEmpKashfTepy(name, cardId, empType);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpKashfTepyReportModel>>> report({
    required bool? all,
    required int? empId,
    required String? fromDate,
    required String? toDate,
  }) async {
    try {
      final httpResponse =
          await _apiService.reportEmpKashfTepy(all, empId, fromDate, toDate);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpKashfTepyModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpKashfTepyById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpKashfTepyModel>> save(
      EmpKashfTepyModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpKashfTepy(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpKashfTepyModel>> update(
      int id, EmpKashfTepyModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpKashfTepy(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpKashfTepy(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
