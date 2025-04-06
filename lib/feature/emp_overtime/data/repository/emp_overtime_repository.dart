import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_overtime_model.dart';

class EmpOvertimeRepository {
  final ApiService _apiService;

  EmpOvertimeRepository(this._apiService);

  Future<Either<Failure, List<EmpOvertimeSearchModel>>> search({
    required String name,
    required String cardId,
    required String place,
  }) async {
    try {
      final httpResponse =
          await _apiService.searchEmpOvertime(name, cardId, place);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpOvertimeModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpOvertimeById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpOvertimeModel>> save(EmpOvertimeModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpOvertime(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpOvertimeModel>> update(
      int id, EmpOvertimeModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpOvertime(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpOvertime(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
