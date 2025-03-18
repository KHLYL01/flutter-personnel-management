import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure {
  final String eerMessage;

  Failure(this.eerMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.eerMessage);

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection timeout with ApiServer');
      case DioExceptionType.sendTimeout:
        return ServerFailure('Send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');
      case DioExceptionType.badCertificate:
        return ServerFailure('there are bad certificate');
      case DioExceptionType.badResponse:
        log("Status code ================================ ${dioException.response!.statusCode!}");
        return ServerFailure.fromResponse(
            dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('cancel the operation');
      case DioExceptionType.connectionError:
        return ServerFailure('there are error in the connection');
      case DioExceptionType.unknown:
        if (dioException.message?.contains('SocketException') ?? false) {
          return ServerFailure('No Internet Connection');
        }
        return ServerFailure(dioException.error.toString());
      default:
        return ServerFailure('unknown error');
    }
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure("be sure you entered a true data");
    } else if (statusCode == 404) {
      return ServerFailure('Your request is not found , Please try again .');
    } else if (statusCode == 500) {
      return ServerFailure('Internal Server error , please try again .');
    } else {
      return ServerFailure('Opps , there was an error , please try again .');
    }
  }
}
