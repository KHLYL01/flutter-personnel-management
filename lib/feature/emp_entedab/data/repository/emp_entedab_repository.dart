import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_entedab_model.dart';

class EmpEntedabRepository {
  final ApiService _apiService;

  EmpEntedabRepository(this._apiService);

  Future<Either<Failure, List<EmpEntedabSearchModel>>> search({
    required String employeeName,
    required String cardId,
    required String entedabPlace,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpEntedab(
          employeeName, cardId, entedabPlace);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpEntedabReportModel>>> report({
    required int? empId,
    required String? fromDate,
    required String? toDate,
  }) async {
    try {
      final httpResponse =
          await _apiService.reportEmpEntedab(empId, fromDate, toDate);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEntedabModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpEntedabById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEntedabModel>> save(EmpEntedabModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpEntedab(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEntedabModel>> update(
      int id, EmpEntedabModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpEntedab(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpEntedab(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
