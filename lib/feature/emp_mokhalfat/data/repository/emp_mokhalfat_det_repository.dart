import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_mokhalfat_det_model.dart';

class EmpMokhalfatDetRepository {
  final ApiService _apiService;

  EmpMokhalfatDetRepository(this._apiService);

  Future<Either<Failure, List<EmpMokhalfatDetModel>>> findEmpMokhalfatDetById(
      int id) async {
    try {
      final httpResponse = await _apiService.findEmpMokhalfatDetById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getNextId() async {
    try {
      final httpResponse = await _apiService.getNextMokhalfatDetId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(EmpMokhalfatDetModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpMokhalfatDet(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpMokhalfatDet(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
