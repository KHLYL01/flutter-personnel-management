import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/banks_model.dart';

class BanksRepository {
  final ApiService _apiService;

  BanksRepository(this._apiService);

  Future<Either<Failure, List<BanksModel>>> findBanks({
    required String? id,
    required String? name,
  }) async {
    try {
      final httpResponse = await _apiService.findBanks(id, name);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BanksModel>> findById({
    required String? id,
  }) async {
    try {
      final httpResponse = await _apiService.findBankById(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<BanksModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllBanks();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BanksModel>> save(BanksModel model) async {
    try {
      final httpResponse = await _apiService.saveBanks(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(String id) async {
    try {
      final httpResponse = await _apiService.deleteBanks(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      log('delete nation exception: ${e.response!.statusCode}');
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
