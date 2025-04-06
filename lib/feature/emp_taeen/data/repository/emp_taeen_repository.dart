import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_taeen_model.dart';

class EmpTaeenRepository {
  final ApiService _apiService;

  EmpTaeenRepository(this._apiService);

  Future<Either<Failure, List<EmpTaeenSearchModel>>> search({
    required String name,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpTaeen(name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTaeenModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpTaeenById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTaeenModel>> save(EmpTaeenModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpTaeen(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTaeenModel>> update(
      int id, EmpTaeenModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpTaeen(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpTaeen(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
