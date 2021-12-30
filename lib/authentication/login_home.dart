import 'package:ambulance_nepal/authentication/login.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginHomePage extends StatelessWidget {
  const LoginHomePage({Key? key}) : super(key: key);

  final double _borderRadius = 25.0;

  Widget individualTileWidget(BuildContext context, IconData icon, String title,
      VoidCallback onTap, Color backgroundColor) {
    return InkWell(
      borderRadius: BorderRadius.circular(_borderRadius),
      splashColor: backgroundColor,
      onTap: onTap,
      child: SizedBox(
        height: Get.size.height * 0.2,
        width: Get.size.width * 0.4,
        child: Card(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_borderRadius),
            side: BorderSide(color: backgroundColor, width: 2.0),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  size: 50.0,
                  color: backgroundColor,
                ),
                const SizedBox(height: 10.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "I am using as",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              Wrap(
                runSpacing: 10.0,
                spacing: 10.0,
                children: [
                  individualTileWidget(context, Icons.people, Constants.public,
                      () {
                    Constants.color = Colors.green[900]!;
                    Constants.loginType = Constants.public;
                    Get.to(() => LoginPage(), transition: Transition.zoom);
                  }, Colors.green[900]!),
                  individualTileWidget(
                      context, Icons.drive_eta, Constants.driver, () {
                    Constants.color = Colors.amber[900]!;
                    Constants.loginType = Constants.driver;
                    Get.to(() => LoginPage(),
                        transition: Transition.rightToLeftWithFade);
                  }, Colors.amber[900]!),
                  individualTileWidget(
                      context, Icons.traffic, Constants.traffic, () {
                    Constants.color = Colors.lightBlue[900]!;
                    Constants.loginType = Constants.traffic;
                    Get.to(() => LoginPage(),
                        transition: Transition.leftToRightWithFade);
                  }, Colors.lightBlue),
                  individualTileWidget(
                      context, Icons.admin_panel_settings, Constants.admin, () {
                    Constants.color = Colors.red[900]!;
                    Constants.loginType = Constants.admin;
                    Get.to(() => LoginPage(), transition: Transition.size);
                  }, Colors.red[900]!),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
