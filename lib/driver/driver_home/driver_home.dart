import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/driver/driver_home/driver_profile.dart';
import 'package:ambulance_nepal/hospitals/view_hospitals.dart';
import 'package:ambulance_nepal/services/firebase_services.dart';
import 'package:ambulance_nepal/settings/settings.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  var controller = Get.put(FirebaseServices(), permanent: true);

  final iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          Get.find<AuthController>().userType!,
          style: TextStyle(color: Constants.color),
        ),
        leading: Icon(
          Icons.drive_eta,
          color: Constants.color,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.verticalPadding),
        child: GridView.count(
          childAspectRatio: 1.2,
          crossAxisCount: 2,
          children: [
            IndividualCardTile(
                title: "Passenger",
                onPressed: () {},
                icon: Icon(
                  Icons.person_search,
                  size: iconSize,
                )),
            IndividualCardTile(
                title: "Hospitals",
                onPressed: () {
                  Get.to(() => ViewHospitalPage());
                },
                icon: Icon(
                  Icons.local_hospital_rounded,
                  size: iconSize,
                )),
            IndividualCardTile(
                title: "Notification",
                onPressed: () {},
                icon: Icon(
                  Icons.notifications,
                  size: iconSize,
                )),
            IndividualCardTile(
                title: "Profile",
                onPressed: () {
                  Get.to(() => DriverProfilePage());
                },
                icon: Icon(
                  Icons.info_outline,
                  size: iconSize,
                )),
            IndividualCardTile(
                title: "Something other",
                onPressed: () {},
                icon: Icon(
                  Icons.devices_other,
                  size: iconSize,
                )),
            IndividualCardTile(
                title: "Settings",
                onPressed: () {
                  Get.to(() => SettingsPage());
                },
                icon: Icon(
                  Icons.settings,
                  size: iconSize,
                )),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class IndividualCardTile extends StatelessWidget {
  IndividualCardTile(
      {Key? key,
      required this.title,
      required this.onPressed,
      required this.icon})
      : super(key: key);

  String title;
  VoidCallback onPressed;
  Icon icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      onTap: onPressed,
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              const SizedBox(
                height: 15.0,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
