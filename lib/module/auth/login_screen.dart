import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otpless_demo/module/auth/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        controller.startLogin();
        return Scaffold(
          appBar: AppBar(),
          body: const Center(child: CircularProgressIndicator.adaptive()),
        );
      },
    );
  }
}
