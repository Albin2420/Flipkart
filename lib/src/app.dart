import 'package:flipkart/src/presentation/screens/splash_screen/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Flipkart extends StatelessWidget {
  const Flipkart({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Splashscreen(),
    );
  }
}
