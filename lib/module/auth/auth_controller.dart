import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otpless_demo/core/constants.dart';
import 'package:otpless_demo/core/pref_utils.dart';
import 'package:otpless_demo/module/auth/auth_service.dart';
import 'package:otpless_demo/module/auth/login_response_data_model.dart';
import 'package:otpless_demo/module/home/home_page.dart';
import 'package:otpless_demo/module/profile/profile_screen.dart';
import 'package:otpless_flutter/otpless_flutter.dart';


class AuthController extends GetxController {
  final AuthService _authService = AuthService.instance;
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  final Otpless otpLessFlutterPlugin = Otpless();

  Rx<bool> isLoading = false.obs;
  final Map<String, String> arg = {'appId': 'UNC07TLUCIIBRXJOP67T'};

  Future<String> getDeviceName() async {
    try {
      final info = await _deviceInfo.androidInfo;
      return "${info.manufacturer} ${info.model}";
    } catch (e) {
      debugPrint("Device info error: $e");
      return "Unknown Device";
    }
  }

  void startLogin() async {
    final String deviceName = await getDeviceName();
    final bool isLogin = await PrefUtils.getLogin();
    final userModel = await PrefUtils.getUserInfo();

    // If already logged in, go forward
    if (isLogin == true && userModel.isDataFetched == true) {
      goToNextAfterLogin();
      return;
    }

    otpLessFlutterPlugin.openLoginPage((result) async {
      if (result == null || result is! Map<String, dynamic>) {
        Constant.vMessage("Login cancelled or failed.");
        return;
      }

      final token = result['response']['token'];
      debugPrint("RECEIVED_TOKEN_FROM_OTPLESS::: $token");

      final data = result['data'];
      if (data == null || data['status'] != "SUCCESS") {
        Constant.vMessage("Login failed. Retrying...");
        startLogin(); // Retry on failure
        return;
      }

      try {
        otpLessFlutterPlugin.setLoaderVisibility(true);
        debugPrint("DEVICE NAME::: $deviceName");
        // Add device name to result map
        result.putIfAbsent("device_name", () => deviceName);
        debugPrint("DEVICE NAME::: ${result.keys} ${result.values}");
        final response = await _authService.sendUser(result);

        response.fold(
          (l) async {
            final model = JobsApp.fromJson(l.data);

            await PrefUtils.setLogin(true);
            await PrefUtils.setUserInfo(
              userId: model.userId,
              token: '',
              isFromEmail:
                  result['data']['identities'][0]['identityType'] == "MOBILE"
                      ? false
                      : true,
            );

            ///change login model according to your api response
            // if (model.userExist == false) {
            //   Get.offAll(() => ProfileScreen(isFirstTime: true));
            //   // Navigate to EditProfileScreen if needed
            //   // Get.offAllNamed(EditProfileScreen.routeName, arguments: "first_login");
            //   return;
            // }
            goToNextAfterLogin();
          },
          (r) {
            Constant.vMessage(r.message);
          },
        );
      } catch (e) {
        debugPrint("Login error: $e");
        Constant.vMessage("Unexpected error occurred during login.");
      } finally {
        otpLessFlutterPlugin.setLoaderVisibility(false);
      }
    }, arg);
  }

  void goToNextAfterLogin() {
    Get.offAll(() => const HomePage());
  }
}
