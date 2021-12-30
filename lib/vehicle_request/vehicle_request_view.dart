import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/map/devices/devices.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class VehicleRequestViewPage extends StatelessWidget {
  VehicleRequestViewPage(
      {Key? key,
      required this.devices,
      required this.latitude,
      required this.longitude})
      : super(key: key);

  Devices devices;
  double latitude;
  double longitude;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _othersController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  var isSelf = false.obs;
  var selectedInjury = "Injury Type".obs;

  final VehicleRequest _vehicleRequest = VehicleRequest();

  final TextStyle _style = const TextStyle(
    fontSize: 16.0,
  );

  List<String> injuryList = const <String>[
    "Fall",
    "Burn",
    "Road Traffic Accident",
    "Posioning",
    "Dog Bite",
    "Snake Bite",
    "Drowning",
    "Fight",
    "Fire",
    "Cut",
    "Fall From Bhir",
    "Unconsiousness",
    "Respiratory Problem",
    "Kidney Problem",
    "HIV AIDS",
    "Hypertension",
    "BP",
    "Heart Problem",
    "Gharelu Hingsha",
    "Natural Disaster",
    "Others",
  ];

  bool validateInput() {
    return _nameController.text.isNotEmpty &&
        selectedInjury.value != "Injury Type";
  }

  bool validateInjury() {
    if (selectedInjury.value == "Others") {
      if (_othersController.text.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }

  handleSubmit() {
    if (validateInput()) {
      if (validateInjury()) {
        _vehicleRequest.lat = latitude.toString();
        _vehicleRequest.long = longitude.toString();
        _vehicleRequest.patientInjuryType =
            selectedInjury.value + "//" + _othersController.text;
        _vehicleRequest.deviceUniqueid = devices.uniqueid.toString();
        _vehicleRequest.remarks = _remarksController.text;
        _vehicleRequest.patientName = _nameController.text;

        Get.find<VehicleRequestController>()
            .sendRequest(_vehicleRequest)
            .then((value) {
          if (value) {
            Constants.isRequestedForVehicle.value = true;
            Get.back();
          }
        });
      } else {
        Utilities.showToast("Please give reason for other injury ",
            toastType: ToastType.error);
      }
    } else {
      Utilities.showToast("Please fill all required field",
          toastType: ToastType.error);
    }
  }

  Widget patientNameField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text("Patient\nName *: ", style: _style),
            // SizedBox(width: Get.size.width * 0.1),
            Expanded(
              child: TextField(
                controller: _nameController,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text("Self "),
            Obx(
              () => Checkbox(
                  value: isSelf.value,
                  onChanged: (value) {
                    isSelf.value = !isSelf.value;
                    if (isSelf.value) {
                      _nameController.text =
                          Get.find<AuthController>().users!.name!;
                    } else {
                      _nameController.text = "";
                    }
                  }),
            )
          ],
        ),
      ],
    );
  }

  Widget injuryField() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Injury*: ",
              style: _style,
            ),
            Obx(
              () => Expanded(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton<String>(
                    isDense: true,
                    isExpanded: true,
                    hint: Text(selectedInjury.value),
                    items: injuryList
                        .map((e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (injury) {
                      selectedInjury.value = injury!;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => selectedInjury.value == "Others"
              ? TextField(
                  controller: _othersController,
                  decoration: const InputDecoration(
                    label: Text("Please Specify*"),
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }

  Widget remarksField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Remarks: ",
          style: _style,
        ),
        Expanded(
          child: TextField(
            controller: _remarksController,
          ),
        ),
      ],
    );
  }

  Widget actionButtons() {
    return ButtonBar(
      children: [
        TextButton(
          onPressed: () {
            handleSubmit();
          },
          child: const Text("Submit"),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            Utilities.showToast("Request Cancelled", toastType: ToastType.info);
          },
          child: const Text("Cancel"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          patientNameField(),
          injuryField(),
          SizedBox(
            height: Get.size.height * 0.02,
          ),
          remarksField(),
          actionButtons(),
          SizedBox(
            height: Get.size.height * 0.01,
          ),
          const Text("* denote required field")
        ],
      ),
    );
  }
}
