import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_hasmiat_model.dart';

class EmpHasmiatRepository {
  final ApiService _apiService;

  EmpHasmiatRepository(this._apiService);

  Future<Either<Failure, List<EmpHasmiatSearchModel>>> search({
    required String name,
    required String cardId,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpHasmiat(name, cardId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpHasmiatReportModel>>> report({
    required bool? all,
    required int? empId,
    required String? fromDate,
    required String? toDate,
  }) async {
    try {
      final httpResponse =
          await _apiService.reportEmpHasmiat(all, empId, fromDate, toDate);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHasmiatModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpHasmiatById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHasmiatModel>> save(EmpHasmiatModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpHasmiat(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHasmiatModel>> update(
      int id, EmpHasmiatModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpHasmiat(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpHasmiat(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
