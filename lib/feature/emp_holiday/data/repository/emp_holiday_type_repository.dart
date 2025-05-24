import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_holiday_type_model.dart';

class EmpHolidayTypeRepository {
  final ApiService _apiService;

  EmpHolidayTypeRepository(this._apiService);

  Future<Either<Failure, List<EmpHolidayTypeModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllEmpHolidayType();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayTypeModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpHolidayTypeById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayTypeModel>> save(
      EmpHolidayTypeModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpHolidayType(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayTypeModel>> update(
      int id, EmpHolidayTypeModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpHolidayType(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpHolidayType(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      log('delete nation exception: ${e.response!.statusCode}');
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
