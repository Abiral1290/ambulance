import 'package:ambulance_nepal/admin/admin_home/admin_checklist_form.dart';
import 'package:ambulance_nepal/ambulance/ambulance_controller.dart';
import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  Widget expansionTileItem(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        SizedBox(
          width: Get.size.width * 0.04,
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 15.0),
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
            Get.find<AuthController>().userType!,
            style: const TextStyle(color: Colors.black),
          ),
          leading: const Icon(
            Icons.admin_panel_settings,
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
      body: GetBuilder<AmbulanceController>(
        builder: (builder) {
          return ListView.builder(
              itemCount: Get.find<AmbulanceController>().ambulanceList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(Constants.verticalPadding),
                  child: ExpansionTile(
                    trailing: IconButton(
                        onPressed: () {
                          if (int.parse(Get.find<AmbulanceController>()
                                  .ambulanceList[index]
                                  .formLevel
                                  .toString()) >
                              8) {
                            Utilities.showToast(
                                "Vehicle has already been rejected 3 times.",
                                toastType: ToastType.info);
                          } else {
                            Get.to(() => AdminChecklistFormPage(
                                ambulance: Get.find<AmbulanceController>()
                                    .ambulanceList[index]));
                          }
                          // Get.to(() => AdminChecklistFormPage(
                          //     ambulance: Get.find<AmbulanceController>()
                          //         .ambulanceList[index]));
                        },
                        icon: Icon(
                          Icons.checklist,
                          color: Constants.color,
                        )),
                    leading: Text(Get.find<AmbulanceController>()
                        .ambulanceList[index]
                        .formLevel
                        .toString()),
                    title: Text(Get.find<AmbulanceController>()
                        .ambulanceList[index]
                        .vehicleName!),
                    subtitle: Text("Category: " +
                        Get.find<AmbulanceController>()
                            .ambulanceList[index]
                            .ambulanceCatagory!),
                    children: [
                      expansionTileItem(
                          "Contact Person Name:",
                          Get.find<AmbulanceController>()
                              .ambulanceList[index]
                              .contactPersonName!),
                      expansionTileItem(
                          "Contact Number:",
                          Get.find<AmbulanceController>()
                              .ambulanceList[index]
                              .contactNo!),
                      expansionTileItem(
                          "Running Organization:",
                          Get.find<AmbulanceController>()
                              .ambulanceList[index]
                              .contactNo!),
                      expansionTileItem(
                          "Hospital Name:",
                          Get.find<AmbulanceController>()
                              .ambulanceList[index]
                              .hospitalName!),
                      expansionTileItem(
                          "Company Name:",
                          Get.find<AmbulanceController>()
                              .ambulanceList[index]
                              .vehicleCompanyname!),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
