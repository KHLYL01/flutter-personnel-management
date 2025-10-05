import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_mobashra_model.dart';

class EmpMobashraRepository {
  final ApiService _apiService;

  EmpMobashraRepository(this._apiService);

  Future<Either<Failure, List<EmpMobashraSearchModel>>> search({
    required String name,
    required String cardId,
    required String empType,
  }) async {
    try {
      final httpResponse =
          await _apiService.searchEmpMobashra(name, cardId, empType);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpMobashraReportModel>>> report({
    required bool? all,
    required int? empId,
    required String? fromDate,
    required String? toDate,
  }) async {
    try {
      final httpResponse =
          await _apiService.reportEmpMobashra(all, empId, fromDate, toDate);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMobashraModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpMobashraById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMobashraModel>> save(EmpMobashraModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpMobashra(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMobashraModel>> update(
      int id, EmpMobashraModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpMobashra(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpMobashra(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
