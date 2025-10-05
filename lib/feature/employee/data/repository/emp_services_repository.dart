import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:personnel_management/feature/employee/data/model/mosaeer_salary_model.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/emp_services_model.dart';
import '../model/employee_model.dart';

class EmpServicesRepository {
  final ApiService _apiService;

  EmpServicesRepository(this._apiService);

  Future<Either<Failure, List<EmpServicesModel>>> search({
    required int? empId,
  }) async {
    try {
      final httpResponse = await _apiService.searchEmpServices(empId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpServicesModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findEmpServicesById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, EmpServicesModel>> save(EmpServicesModel model) async {
    try {
      final httpResponse = await _apiService.saveEmpServices(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteEmpServices(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
