import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_mokhalfat_model.dart';

class EmpMokhalfatRepository {
  final ApiService _apiService;

  EmpMokhalfatRepository(this._apiService);

  Future<Either<Failure, List<EmpMokhalfatSearchModel>>> search({
    required String name,
    required String cardId,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpMokhalfat(name, cardId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMokhalfatModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpMokhalfatById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMokhalfatModel>> save(
      EmpMokhalfatModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpMokhalfat(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpMokhalfatModel>> update(
      int id, EmpMokhalfatModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpMokhalfat(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpMokhalfat(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
