import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/actions_model.dart';

class ActionsRepository {
  final ApiService _apiService;

  ActionsRepository(this._apiService);

  Future<Either<Failure, List<ActionsModel>>> search({
    required int? id,
    required String? username,
    required String? type,
    required String? action,
    required bool? all,
    required String? fromDate,
    required String? toDate,
  }) async {
    try {
      final httpResponse = await _apiService.searchActions(
        id,
        username,
        type,
        action,
        all,
        fromDate,
        toDate,
      );
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, ActionsModel>> save(ActionsModel model) async {
    try {
      final httpResponse = await _apiService.saveActions(model);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}