import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/traffic/traffic_home/traffic_checklist_form.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrafficHomePage extends StatelessWidget {
  const TrafficHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          Text(
            Get.find<AuthController>().userType!,
            style: const TextStyle(color: Colors.black),
          ),
          leading: const Icon(
            Icons.traffic,
            color: Colors.black,
          ),
          actions: [
            IconButton(
              onPressed: () async {
                var confirm = await Utilities.showConfirmationDialog(context,
                    "Confirmation", "Are you sure you want to logout?");
                print(confirm);
                if (confirm) {
                  Utilities.logout();
                }
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
            )
          ]),
      body: Center(
        child: InkWell(
          child: Text(
            "Checklist Form",
            style: TextStyle(fontSize: 18.0, color: Colors.red[900]),
          ),
          onTap: () {
            Get.to(() => TrafficChecklistFormPage());
          },
        ),
      ),
    );
  }
}
