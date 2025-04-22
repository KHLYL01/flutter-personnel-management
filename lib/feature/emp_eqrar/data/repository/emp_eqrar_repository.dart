import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_eqrar_model.dart';

class EmpEqrarRepository {
  final ApiService _apiService;

  EmpEqrarRepository(this._apiService);

  Future<Either<Failure, List<EmpEqrarSearchModel>>> search({
    required String name,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpEqrar(name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEqrarModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpEqrarById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEqrarModel>> save(EmpEqrarModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpEqrar(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpEqrarModel>> update(
      int id, EmpEqrarModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpEqrar(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpEqrar(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
