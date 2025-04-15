import 'package:dio/dio.dart';

abstract class Failure {}

// General failures
class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

String dioHandler(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return "Failed to connect to server.";
    case DioExceptionType.sendTimeout:
      return "Failed to connect to server.";
    case DioExceptionType.receiveTimeout:
      return "Failed to connect to server.";
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        if (error.response?.data?["message"] != null ||
            error.response?.data?["error"] != null) {
          return error.response?.data?['message'] ??
              error.response?.data?['error'] ??
              "Unknown Error occured";
        } else {
          return error.response?.statusMessage ??
              "Unknown Error occured.Please try again later.";
        }
      } else {
        return "Unknown Error";
      }
    case DioExceptionType.cancel:
      return "Operation canceled by user.";
    default:
      return "Error Found";
  }
}
