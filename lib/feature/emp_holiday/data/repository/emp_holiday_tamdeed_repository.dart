import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_holiday_tamdeed_model.dart';

class EmpHolidayTamdeedRepository {
  final ApiService _apiService;

  EmpHolidayTamdeedRepository(this._apiService);
  //
  // Future<Either<Failure, int>> getNextHolidayTamdeedId() async {
  //   try {
  //     final httpResponse = await _apiService.getNextHolidayTamdeedId();
  //     return Right(httpResponse.data);
  //   } on DioException catch (e) {
  //     return Left(ServerFailure.fromDioError(e));
  //   } catch (e) {
  //     return Left(ServerFailure(e.toString()));
  //   }
  // }

  Future<Either<Failure, List<EmpHolidayTamdeedModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllHolidayTamdeed();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<EmpHolidayTamdeedModel>>>
      findAllByHolidayTamdeedsId(int id) async {
    try {
      final httpResponse =
          await _apiService.findEmpHolidayTamdeedByHolidaysId(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayTamdeedModel>> save(
      EmpHolidayTamdeedModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpHolidayTamdeed(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpHolidayTamdeed(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
