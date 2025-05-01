import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_entedab_det_model.dart';

class EmpEntedabDetRepository {
  final ApiService _apiService;

  EmpEntedabDetRepository(this._apiService);

  Future<Either<Failure, List<EmpEntedabDetModel>>> findEmpEntedabDetById(
      int id) async {
    try {
      final httpResponse = await _apiService.findEmpEntedabDetById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, int>> getNextId() async {
    try {
      final httpResponse = await _apiService.getNextEntedabDetId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(EmpEntedabDetModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpEntedabDet(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpEntedabDet(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
