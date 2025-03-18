import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/bladia_info_model.dart';

class BladiaInfoRepository {
  final ApiService _apiService;

  BladiaInfoRepository(this._apiService);

  Future<Either<Failure, BladiaInfoModel>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllBladias();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> save(BladiaInfoModel model) async {
    try {
      final httpResponse = await _apiService.saveBladia(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
