import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_takleef_det_model.dart';

class EmpTakleefDetRepository {
  final ApiService _apiService;

  EmpTakleefDetRepository(this._apiService);

  Future<Either<Failure, List<EmpTakleefDetModel>>> findEmpTakleefDetById(
      int id) async {
    try {
      final httpResponse = await _apiService.findEmpTakleefDetById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getNextId() async {
    try {
      final httpResponse = await _apiService.getNextTakleefDetId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(EmpTakleefDetModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpTakleefDet(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpTakleefDet(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
