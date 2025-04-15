import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otpless_demo/module/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late Timer timer;

  @override
  void initState() {
    _navigation();
    super.initState();
  }

  _navigation() async {
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Get.offAll(() => LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/otpless_dark.png', scale: 4),
      ),
    );
  }
}
