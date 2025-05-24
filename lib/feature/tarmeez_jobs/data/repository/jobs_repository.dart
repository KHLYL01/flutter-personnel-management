import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/jobs_model.dart';

class JobsRepository {
  final ApiService _apiService;

  JobsRepository(this._apiService);

  Future<Either<Failure, List<JobsModel>>> findJobs({
    required int? id,
    required String? name,
  }) async {
    try {
      final httpResponse = await _apiService.findJobs(id, name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, JobsModel>> findById({
    required int? id,
  }) async {
    try {
      final httpResponse = await _apiService.findJobById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<JobsModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllJobs();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, JobsModel>> save(JobsModel model) async {
    try {
      final httpResponse = await _apiService.saveJobs(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, JobsModel>> update(int id, JobsModel model) async {
    try {
      final httpResponse = await _apiService.updateJobs(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteJobs(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
