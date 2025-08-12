import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:personnel_management/core/network/api_constants.dart';

import '../../../../core/utils/failures.dart';
import '../../../../core/network/api_service.dart';
import '../model/signature_model.dart';

class SignatureRepository {
  final ApiService _apiService;
  final Dio dio;

  SignatureRepository(this._apiService, this.dio);

  Future<Either<Failure, List<SignatureModel>>> findAll() async {
    try {
      final httpResponse = await _apiService.findAllSignatures();
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<SignatureModel>>> findAllByUserId(
      int userId) async {
    try {
      final httpResponse = await _apiService.findAllSignaturesByUserId(userId);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, SignatureModel>> findById(int id) async {
    try {
      final httpResponse = await _apiService.findBySignatureId(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> save({
    required MultipartFile image,
    required String content,
    required String password,
    required int userId,
  }) async {
    try {
      final formData = FormData.fromMap({
        "image": image,
        "content": content,
        "password": password,
        "userId": userId,
      });

      final httpResponse = await dio.post(baseURL + signatures,
          data: formData,
          options: Options(
              contentType: "multipart/form-data",
              headers: {"Content-Type": "multipart/form-data"}));
      // await _apiService.saveSignature(image, content, password, userId);
      // final httpResponse = await _apiService.saveSignature(formData);
      return const Right("");
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> delete(int id) async {
    try {
      final httpResponse = await _apiService.deleteSignature(id);
      return Right(httpResponse.data);
    } on DioException catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
