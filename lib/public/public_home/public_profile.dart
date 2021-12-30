import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:ambulance_nepal/widget/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicProfilePage extends StatelessWidget {
  PublicProfilePage({Key? key}) : super(key: key);

  final controller = Get.find<AuthController>().getProfile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Profile",
          style: TextStyle(color: Constants.color),
        ),
        leading: Icon(
          Icons.person,
          color: Constants.color,
        ),
        color: Constants.color,
      ),
      body: GetBuilder<AuthController>(
        builder: (builder) {
          return Get.find<AuthController>().userProfile == null
              ? Center(
                  child: InkWell(
                    onTap: () {
                      Get.find<AuthController>().getProfile();
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text("Could not get profile!"),
                            Text("Try Again"),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : ProfilePage(user: Get.find<AuthController>().userProfile);
        },
      ),
    );
  }
}
 