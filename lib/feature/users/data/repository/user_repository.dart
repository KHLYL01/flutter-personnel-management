import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/user_model.dart';

class UserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  Future<Either<Failure, int>> getNext() async {
    try {
      final httpResponse = await _apiService.getNextUserId();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserDtoModel>>> findAllUsers() async {
    try {
      final httpResponse = await _apiService.findAllUsers();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserModel>>> findAllById(int id) async {
    try {
      final httpResponse = await _apiService.findAllByUserId(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<UserModel>>> saveAllForUserId(
      List<UserModel> list) async {
    try {
      final httpResponse = await _apiService.saveAllForUserId(list);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> deleteAllByUserId(int id) async {
    try {
      final httpResponse = await _apiService.deleteAllByUserId(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
