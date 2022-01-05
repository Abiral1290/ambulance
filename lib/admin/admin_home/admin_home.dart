import 'package:ambulance_nepal/admin/admin_home/admin_checklist_form.dart';
import 'package:ambulance_nepal/ambulance/ambulance.dart';
import 'package:ambulance_nepal/ambulance/ambulance_controller.dart';
import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdminHomePage extends StatelessWidget {
  AdminHomePage({Key? key}) : super(key: key);

  var searchPressed = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Obx(() => searchPressed.value
            ? TextField(
                decoration: InputDecoration(
                  label: const Text("Search"),
                  suffixIcon: IconButton(
                    onPressed: () {
                      Get.find<AmbulanceController>().clearSearch();
                      searchPressed.value = false;
                    },
                    icon: const Icon(Icons.cancel),
                  ),
                  enabledBorder:
                      const UnderlineInputBorder(borderSide: BorderSide()),
                ),
                onChanged: (text) {
                  Get.find<AmbulanceController>().searchAmbulance(text);
                },
                autofocus: true,
              )
            : Text(
                Get.find<AuthController>().userType!,
                style: TextStyle(color: Constants.color),
              )),
        leading: Icon(
          Icons.admin_panel_settings,
          color: Constants.color,
        ),
        actions: [
          Obx(() => searchPressed.value
              ? const SizedBox.shrink()
              : IconButton(
                  onPressed: () async {
                    searchPressed.value = true;
                  },
                  icon: Icon(
                    Icons.search,
                    color: Constants.color,
                  ),
                )),
          IconButton(
            onPressed: () async {
              var confirm = await Utilities.showConfirmationDialog(
                  context, "Confirmation", "Are you sure you want to logout?");
              print(confirm);
              if (confirm) {
                Utilities.logout();
              }
            },
            icon: Icon(
              Icons.logout,
              color: Constants.color,
            ),
          ),
        ],
        color: Constants.color,
      ),
      body: GetBuilder<AmbulanceController>(
        builder: (builder) {
          return Get.find<AmbulanceController>()
                  .searchedAmbulanceList
                  .isNotEmpty
              ? AmbulanceListwidget(
                  ambulanceList:
                      Get.find<AmbulanceController>().searchedAmbulanceList)
              : AmbulanceListwidget(
                  ambulanceList: Get.find<AmbulanceController>().ambulanceList);
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class AmbulanceListwidget extends StatelessWidget {
  AmbulanceListwidget({Key? key, required this.ambulanceList})
      : super(key: key);

  List<Ambulance> ambulanceList;

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
    return ListView.builder(
      itemCount: ambulanceList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: ExpansionTile(
            trailing: IconButton(
                onPressed: () {
                  if (int.parse(ambulanceList[index].formLevel.toString()) >
                      7) {
                    Utilities.showToast(
                        "Vehicle has already been rejected 3 times.",
                        toastType: ToastType.info);
                  } else {
                    Get.to(() => AdminChecklistFormPage(
                        ambulance: ambulanceList[index]));
                  }
                },
                icon: Icon(
                  Icons.checklist,
                  color: Constants.color,
                )),
            leading: Text(ambulanceList[index].formLevel.toString()),
            title: Text(ambulanceList[index].vehicleName!),
            subtitle:
                Text("Category: " + ambulanceList[index].ambulanceCatagory!),
            children: [
              expansionTileItem(
                  "Vehicle Number:", ambulanceList[index].vehicleNumber!),
              expansionTileItem("Contact Person Name:",
                  ambulanceList[index].contactPersonName!),
              expansionTileItem(
                  "Contact Number:", ambulanceList[index].contactNo!),
              expansionTileItem(
                  "Running Organization:", ambulanceList[index].contactNo!),
              expansionTileItem(
                  "Hospital Name:", ambulanceList[index].hospitalName!),
              expansionTileItem(
                  "Company Name:", ambulanceList[index].vehicleCompanyname!),
            ],
          ),
        );
      },
    );
  }
}
