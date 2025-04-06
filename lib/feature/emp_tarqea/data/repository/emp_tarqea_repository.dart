import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_tarqea_model.dart';

class EmpTarqeaRepository {
  final ApiService _apiService;

  EmpTarqeaRepository(this._apiService);

  Future<Either<Failure, List<EmpTarqeaSearchModel>>> search({
    required String qrarId,
    required String name,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpTarqea(qrarId, name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTarqeaModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpTarqeaById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTarqeaModel>> save(EmpTarqeaModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpTarqea(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpTarqeaModel>> update(
      int id, EmpTarqeaModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpTarqea(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpTarqea(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
