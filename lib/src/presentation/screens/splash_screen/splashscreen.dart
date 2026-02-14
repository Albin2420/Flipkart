import 'package:flipkart/src/presentation/controller/app_startup_controller.dart/app_startup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AppStartupController());

    const primaryColor = Color(0xFFE4CF0C);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(child: Image.asset(scale: 2, "assets/icons/Flipkart.png")),
    );
  }
}
