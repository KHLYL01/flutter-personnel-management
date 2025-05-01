import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_hasmiat_det_model.dart';
import '../model/emp_hasmiat_model.dart';

class EmpHasmiatDetRepository {
  final ApiService _apiService;

  EmpHasmiatDetRepository(this._apiService);

  Future<Either<Failure, List<EmpHasmiatDetModel>>> findEmpHasmiatDetById(
      int id) async {
    try {
      final httpResponse = await _apiService.findEmpHasmiatDetById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getNextId() async {
    try {
      final httpResponse = await _apiService.getNextHasmiatDetId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(EmpHasmiatDetModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpHasmiatDet(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpHasmiatDet(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
