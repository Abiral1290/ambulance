import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          Text(
            Get.find<AuthController>().userType!,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.find<AuthController>().signout();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ))
          ]),
      body: const Center(
        child: Text("Congratulations! you are logged in"),
      ),
    );
  }
}
