import 'package:ambulance_nepal/hospitals/view_hospitals.dart';
import 'package:ambulance_nepal/public/public_home/public_map.dart';
import 'package:ambulance_nepal/public/public_home/public_map_trip_accepted.dart';
import 'package:ambulance_nepal/public/public_home/public_profile.dart';
import 'package:ambulance_nepal/services/firebase_services.dart';
import 'package:ambulance_nepal/settings/settings.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PublicHomePage extends StatefulWidget {
  const PublicHomePage({Key? key}) : super(key: key);

  @override
  State<PublicHomePage> createState() => _PublicHomePageState();
}

class _PublicHomePageState extends State<PublicHomePage> {
  var controller = Get.put(FirebaseServices(), permanent: true);

  var currentIndex = 0.obs;

  List<BottomNavigationBarItem> itemList = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.map_outlined),
      activeIcon: Icon(
        Icons.map,
      ),
      label: "Map",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person_outlined),
      activeIcon: Icon(
        Icons.person,
      ),
      label: "Profile",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.local_hospital_outlined),
      activeIcon: Icon(
        Icons.local_hospital,
      ),
      label: "Other Item",
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings_outlined),
      activeIcon: Icon(
        Icons.settings,
      ),
      label: "Settings",
    ),
  ];

  final bodyWidget = [
    Obx(
      () => Constants.isTripAccepted.value
          ? const PublicMaptripAcceptedPage()
          : const PublicMapPage(),
    ),
    PublicProfilePage(),
    ViewHospitalPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
            bottom: Constants.verticalPadding, left: 20, right: 20.0),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: Obx(
              () => BottomNavigationBar(
                items: itemList,
                currentIndex: currentIndex.value,
                showUnselectedLabels: false,
                elevation: 3.0,
                enableFeedback: true,
                selectedItemColor: Constants.color,
                unselectedItemColor: Constants.color.withOpacity(0.5),
                onTap: (index) {
                  currentIndex.value = index;
                },
              ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: currentIndex.value,
          children: bodyWidget,
        ),
      ),
      extendBody: true,
    );
  }
}
