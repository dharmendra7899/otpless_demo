import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:otpless_demo/core/urls.dart';
import 'package:otpless_demo/network/api.dart';
import 'package:otpless_demo/network/api_response.dart';
import 'package:otpless_demo/network/errors/exceptions.dart';

abstract interface class AuthDataSource {
  Future<Either<ApiResponse, YServerException>> sendUser(
    Map<String, dynamic> map,
  );
}

class AuthDataSourceImpl implements AuthDataSource {
  final Api _api = Api();

  @override
  Future<Either<ApiResponse, YServerException>> sendUser(
    Map<String, dynamic> map,
  ) async {
    try {
      final response = await _api.sendRequest.request(
        YUrls.loginEndPoint,
        options: Options(method: "POST"),
        data: jsonEncode(map),
      );
      ApiResponse responseModel = ApiResponse.fromResponse(response);
      if (responseModel.success) {
        return left(responseModel);
      } else {
        return right(YServerException(responseModel.message));
      }
    } on DioException catch (e) {
      return right(
        YServerException(
          e.response?.data['message'] ??
              e.response?.data['error'] ??
              "Something went wrong",
        ),
      );
    }
  }
}
