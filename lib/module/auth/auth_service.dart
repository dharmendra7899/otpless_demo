import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:otpless_demo/module/auth/auth_call.dart';
import 'package:otpless_demo/network/api_response.dart';
import 'package:otpless_demo/network/errors/exceptions.dart';

class AuthService extends GetxController {
  static AuthService get instance =>
      Get.isRegistered() ? Get.find() : Get.put(AuthService());
  final _authCall = AuthDataSourceImpl();

  Future<Either<ApiResponse, YServerException>> sendUser(
      Map<String, dynamic> map) =>
      _authCall.sendUser(map);
}