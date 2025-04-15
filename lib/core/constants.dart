import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Constant {
  static closeApp() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  static backToPrev(BuildContext context) {
    Get.back();
  }

  static sendToNextScreen(BuildContext context, String routes,
      {var arguments}) {
    if (arguments != null) {
      Get.toNamed(routes, arguments: arguments);
    } else {
      Get.toNamed(routes);
    }
  }

  static vMessage(String text) {
    if (text.length <= 5 ||
        text.trim().toLowerCase() == "server error".trim().toLowerCase()) {
      return;
    }
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.black87,
        textColor: Colors.white,
        gravity: ToastGravity.BOTTOM,
        fontSize: 14);
  }
}

AppBar getInVisibleAppBar(
    {Color color = Colors.transparent,
    Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness}) {
  return AppBar(
    toolbarHeight: 0,
    elevation: 0,
    backgroundColor: color,
    scrolledUnderElevation: 0,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: color,
      statusBarIconBrightness: statusBarIconBrightness,
      statusBarBrightness: statusBarBrightness,
    ),
  );
}

Widget animationFunction(
  index,
  child, {
  Duration? listAnimation,
  Duration? slideDuration,
  Duration? slideDelay,
}) {
  return AnimationConfiguration.staggeredList(
    position: index,
    duration: listAnimation ?? const Duration(milliseconds: 800),
    child: SlideAnimation(
      duration: slideDuration ?? const Duration(milliseconds: 500),
      delay: slideDelay ?? const Duration(milliseconds: 50),
      child: FadeInAnimation(
        child: child,
      ),
    ),
  );
}
