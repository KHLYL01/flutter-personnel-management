import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/nations_model.dart';

class NationsRepository {
  final ApiService _apiService;

  NationsRepository(this._apiService);

  Future<Either<Failure, List<NationsModel>>> findNations({
    required int? id,
    required String? name,
  }) async {
    try {
      final httpResponse = await _apiService.findNations(id, name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, NationsModel>> findById({
    required int? id,
  }) async {
    try {
      final httpResponse = await _apiService.findNationById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<NationsModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllNations();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, NationsModel>> save(NationsModel model) async {
    try {
      final httpResponse = await _apiService.saveNations(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, NationsModel>> update(
      int id, NationsModel model) async {
    try {
      final httpResponse = await _apiService.updateNations(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteNations(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      log('delete nation exception: ${e.response!.statusCode}');
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
