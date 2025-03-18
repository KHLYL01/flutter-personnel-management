import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/badal_countries_model.dart';

class BadalCountriesRepository {
  final ApiService _apiService;

  BadalCountriesRepository(this._apiService);

  Future<Either<Failure, List<BadalCountriesModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllBadalCountries();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BadalCountriesModel>> save(
      BadalCountriesModel model) async {
    try {
      final httpResponse = await _apiService.saveBadalCountries(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, BadalCountriesModel>> update(
      int id, BadalCountriesModel model) async {
    try {
      final httpResponse = await _apiService.updateBadalCountries(id, model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteBadalCountries(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
