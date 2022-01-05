import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/driver/driver_controller.dart';
import 'package:ambulance_nepal/hospitals/hospitals_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:ambulance_nepal/widget/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DriverProfilePage extends StatelessWidget {
  DriverProfilePage({Key? key}) : super(key: key);

  final authController = Get.find<AuthController>().getProfile();
  final driverController = Get.put(DriverController());

  onRefresh() {
    Get.find<AuthController>().getProfile();
    Get.find<DriverController>().fetchAddress();
    Get.find<HospitalsController>().fetchHospitals();
  }

  Widget buildRowTile(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          key,
          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 17.0),
        ),
      ],
    );
  }

  Widget buildUserImage() {
    return CircleAvatar(
      radius: 70.0,
      backgroundImage:
          NetworkImage(Get.find<AuthController>().userProfile.driverPhoto),
    );
  }

  Widget buildAddress() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Address:",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          GetBuilder<DriverController>(builder: (builder) {
            return Get.find<DriverController>().addressList.isEmpty
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      children: [
                        buildRowTile(
                            "Province",
                            Get.find<DriverController>()
                                .getUserAddress(Get.find<AuthController>()
                                    .userProfile
                                    .addressId)
                                .province!),
                        buildRowTile(
                            "District",
                            Get.find<DriverController>()
                                .getUserAddress(Get.find<AuthController>()
                                    .userProfile
                                    .addressId)
                                .district!),
                        buildRowTile(
                            "City",
                            Get.find<DriverController>()
                                .getUserAddress(Get.find<AuthController>()
                                    .userProfile
                                    .addressId)
                                .localLevelEn!),
                        buildRowTile("Area",
                            Get.find<AuthController>().userProfile.address),
                        buildRowTile(
                            "Woda No",
                            Get.find<AuthController>()
                                .userProfile
                                .wodaNo
                                .toString()),
                      ],
                    ),
                  );
          }),
        ],
      ),
    );
  }

  Widget buildHospital() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hospital:",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          GetBuilder<DriverController>(builder: (builder) {
            return Get.find<HospitalsController>().hospitalList.isEmpty
                ? const Center(child: CircularProgressIndicator.adaptive())
                : Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      Get.find<HospitalsController>()
                          .getUserHospital(
                              Get.find<AuthController>().userProfile.hospitalId)
                          .hospitalName!,
                      style: const TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
          })
        ],
      ),
    );
  }

  Widget buildDob() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "DoB:",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              Get.find<AuthController>().userProfile.dob,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildLicenseNumber() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        // mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "License Number:",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              Get.find<AuthController>().userProfile.licenceNumber,
              style: const TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildImages() {
    return Row(
      children: [
        SizedBox(
          height: Get.size.height * 0.3,
          width: Get.size.width * 0.45,
          child: Card(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  Get.find<AuthController>().userProfile.licencePhoto),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          height: Get.size.height * 0.3,
          width: Get.size.width * 0.45,
          child: Card(
            child: FittedBox(
              fit: BoxFit.fill,
              child: Image.network(
                  Get.find<AuthController>().userProfile.trainingCertificate),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Profile",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          onRefresh();
        },
        child: GetBuilder<AuthController>(
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
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(Constants.verticalPadding),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: CircleAvatar(
                              backgroundColor:
                                  Get.find<AuthController>().userProfile.flag ==
                                          0
                                      ? Colors.green
                                      : Colors.red,
                              radius: 10,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: buildUserImage(),
                              ),
                              ProfilePage(
                                  user: Get.find<AuthController>().userProfile),
                              buildAddress(),
                              const Divider(
                                thickness: 2.0,
                              ),
                              buildHospital(),
                              const Divider(
                                thickness: 2.0,
                              ),
                              buildDob(),
                              const Divider(
                                thickness: 2.0,
                              ),
                              buildLicenseNumber(),
                              const Divider(
                                thickness: 2.0,
                              ),
                              buildImages(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
