import 'package:ambulance_nepal/admin/admin_home/admin_home.dart';
import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/authentication/login_home.dart';
import 'package:ambulance_nepal/driver/driver_home/driver_home.dart';

import 'package:ambulance_nepal/public/public_home/public_home.dart';
import 'package:ambulance_nepal/traffic/traffic_home/traffic_home.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Checkauth extends StatelessWidget {
  const Checkauth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (builder) {
      if (Get.find<AuthController>().userType != null) {
        if (Get.find<AuthController>().userType!.toLowerCase() ==
            Constants.driver.toLowerCase()) {
          return const DriverHomePage();
        } else if (Get.find<AuthController>().userType!.toLowerCase() ==
            Constants.public.toLowerCase()) {
          return const PublicHomePage();
        } else if (Get.find<AuthController>().userType!.toLowerCase() ==
            Constants.traffic.toLowerCase()) {
          return const TrafficHomePage();
        } else {
          return AdminHomePage();
        }
      } else {
        return const LoginHomePage();
      }
    });
  }
}
