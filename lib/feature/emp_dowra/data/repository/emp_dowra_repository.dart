import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_dowra_model.dart';

class EmpDowraRepository {
  final ApiService _apiService;

  EmpDowraRepository(this._apiService);

  Future<Either<Failure, List<EmpDowraSearchModel>>> search({
    required String name,
    required String cardId,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpDowra(name, cardId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDowraModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpDowraById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDowraModel>> save(EmpDowraModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpDowra(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpDowraModel>> update(
      int id, EmpDowraModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpDowra(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpDowra(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
