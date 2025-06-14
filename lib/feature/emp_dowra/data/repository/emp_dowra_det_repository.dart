import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_dowra_det_model.dart';

class EmpDowraDetRepository {
  final ApiService _apiService;

  EmpDowraDetRepository(this._apiService);

  Future<Either<Failure, List<EmpDowraDetModel>>> findEmpDowraDetById(
      int id) async {
    try {
      final httpResponse = await _apiService.findEmpDowraDetById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getNextId() async {
    try {
      final httpResponse = await _apiService.getNextDowraDetId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(EmpDowraDetModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpDowraDet(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpDowraDet(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
