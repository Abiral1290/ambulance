import 'dart:async';

import 'package:ambulance_nepal/authentication/checkauth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 150), () {
      Get.off(() => const Checkauth());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/ams_banner.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Image.asset("assets/images/ams_transparent.png"),
        ),
      ),
    );
  }
}
