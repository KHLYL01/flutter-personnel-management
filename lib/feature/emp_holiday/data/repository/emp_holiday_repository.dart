import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_holiday_model.dart';

class EmpHolidayRepository {
  final ApiService _apiService;

  EmpHolidayRepository(this._apiService);

  Future<Either<Failure, List<EmpHolidaySearchModel>>> search({
    required int? empId,
    required String name,
    required String cardId,
    required String empType,
    required int? holidayType,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpHoliday(
        empId,
        name,
        cardId,
        empType,
        holidayType,
      );
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpHolidayById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayModel>> save(EmpHolidayModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpHoliday(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpHolidayModel>> update(
      int id, EmpHolidayModel model) async {
    try {
      final httpResponse = await _apiService.updateEmpHoliday(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpHoliday(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
