import 'dart:developer';

import 'package:flipkart/src/presentation/screens/home_screen/home_screen.dart';
import 'package:get/get.dart';

class AppStartupController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    nav();
  }

  Future<void> nav() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      Get.offAll(() => HomeScreen());
    } catch (e) {
      log("💥 Exception in nav():$e");
    }
  }
}
