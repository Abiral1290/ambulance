import 'package:ambulance_nepal/public/public_home/public_map.dart';
import 'package:ambulance_nepal/public/public_home/public_map_trip_accepted.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PublicMapHomePage extends StatelessWidget {
  const PublicMapHomePage({Key? key}) : super(key: key);

  Widget categoryTile(String title, IconData iconData, VoidCallback onTap) {
    return SizedBox(
      height: Get.size.height * 0.3,
      width: Get.size.width,
      child: InkWell(
        onTap: onTap,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          elevation: 5.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              SizedBox(
                height: Get.size.height * 0.02,
              ),
              Icon(
                iconData,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                categoryTile("Request Ambulance", Icons.airport_shuttle, () {
                  Get.to(
                    () => Obx(
                      () => Constants.isTripAccepted.value
                          ? const PublicMaptripAcceptedPage()
                          : const PublicMapPage(),
                    ),
                  );
                }),
                categoryTile("Request Sab Bahan",
                    Icons.airline_seat_flat_rounded, () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
