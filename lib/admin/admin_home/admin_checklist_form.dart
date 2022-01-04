import 'package:ambulance_nepal/admin/admin_checklist.dart';
import 'package:ambulance_nepal/admin/admin_controller.dart';
import 'package:ambulance_nepal/ambulance/ambulance.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class AdminChecklistFormPage extends StatelessWidget {
  AdminChecklistFormPage({Key? key, required this.ambulance}) : super(key: key);

  Ambulance ambulance;

  final TextEditingController _vehicleNumberController =
      TextEditingController();

  final TextEditingController _medicineController = TextEditingController();

  final TextEditingController _rejectedMessageController =
      TextEditingController();

  var checked = List<bool>.generate(35, (index) => false).obs;

  final _acceptStatus = AcceptStatus.none.obs;

  int count = 0; //accept or reject count

  Widget buildVehicleNumberField() {
    return Row(
      children: [
        const Text(
          "Vehicle Number*: ",
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        SizedBox(
          width: Get.width * 0.05,
        ),
        Expanded(
          child: TextField(
            controller: _vehicleNumberController,
          ),
        ),
      ],
    );
  }

  Widget buildIndividualItem(String itemName, int index) {
    return Obx(
      () => CheckboxListTile(
          title: Text(itemName),
          value: checked[index],
          onChanged: (value) {
            checked[index] = !checked[index];
          }),
    );
    // return Row(
    //   children: [
    //     Text(itemName),
    //     const Spacer(),
    //     Row(
    //       children: [
    //         Obx(
    //           () => Checkbox(
    //               value: checked[index],
    //               onChanged: (value) {
    //                 checked[index] = !checked[index];
    //               }),
    //         )
    //       ],
    //     ),
    //   ],
    // );
  }

  validateInput() {
    return _vehicleNumberController.text.isNotEmpty &&
        _acceptStatus.value != AcceptStatus.none;
  }

  AdminChecklist assignValue() {
    AdminChecklist checklist = AdminChecklist();
    checklist.ambulanceId = ambulance.id;
    checklist.ambulanceType = ambulance.ambulanceCatagory;
    checklist.rejectedMessage = _rejectedMessageController.text;
    checklist.rejectedType = count.toString();
    checklist.vehicleNumber = _vehicleNumberController.text;
    checklist.medicines = _medicineController.text;
    checklist.stethoscope = checked[1].toString();
    checklist.bpSet = checked[2].toString();
    checklist.trouchLight = checked[3].toString();
    checklist.tongueDepressure = checked[4].toString();
    checklist.ivDrips = checked[5].toString();
    checklist.cannulaAndSyringes = checked[6].toString();
    checklist.ecgMoniterAndOxygenMoniter = checked[7].toString();
    checklist.intubationSet = checked[8].toString();
    checklist.variousIntubationTubesAndLaryngealTubes = checked[9].toString();
    checklist.nebulizerSet = checked[10].toString();
    checklist.ambuBag = checked[11].toString();
    checklist.manualSuctionSet = checked[12].toString();
    checklist.cervicalCollars = checked[13].toString();
    checklist.cprBoard = checked[14].toString();
    checklist.oxygenSupply = checked[15].toString();
    checklist.automatedExternalDefibrillator = checked[16].toString();
    checklist.deliverySets = checked[17].toString();
    checklist.dressingSets = checked[18].toString();
    checklist.splints = checked[19].toString();
    checklist.catheterizationsSets = checked[20].toString();
    checklist.haemostaticSets = checked[21].toString();
    checklist.aEmergencyMedicines = checked[22].toString();
    checklist.aTravellingVentilator = checked[23].toString();
    checklist.aChestDrainageTubes = checked[24].toString();
    checklist.others = checked[25].toString();
    checklist.washingEquipment = checked[26].toString();
    checklist.wheelchairAndTrolley = checked[27].toString();
    checklist.radioCommunication = checked[28].toString();
    checklist.twoWayVideoConsultationDevice = checked[29].toString();
    checklist.mobileDeviceWith4gConnectivity = checked[30].toString();
    checklist.walkieTalkie = checked[31].toString();
    checklist.camera = checked[32].toString();
    checklist.gps = checked[33].toString();
    return checklist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Vehicle Checklist",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Column(
            children: [
              buildVehicleNumberField(),
              buildIndividualItem("Stethoscope", 1),
              buildIndividualItem("B.P set", 2),
              buildIndividualItem("Torch Light", 3),
              buildIndividualItem("Tongue Depressure", 4),
              buildIndividualItem("IV Drips", 5),
              buildIndividualItem("Cannula and Syringes", 6),
              buildIndividualItem("ECG monitor and oxygen monitor", 7),
              buildIndividualItem("Intubation set", 8),
              buildIndividualItem(
                  "Various intubation tubes and laryngeal tubes", 9),
              buildIndividualItem("Nebulizer set", 10),
              buildIndividualItem("Ambu bag", 11),
              buildIndividualItem("Manual suction set", 12),
              buildIndividualItem("Cervical collars", 13),
              buildIndividualItem("CPR board", 14),
              buildIndividualItem("Oxygen supply", 15),
              buildIndividualItem("Automated external defibrillator (AED)", 16),
              buildIndividualItem("Delivery sets", 17),
              buildIndividualItem("Dressing Sets", 18),
              buildIndividualItem("Splints", 19),
              buildIndividualItem("Catheterizations sets", 20),
              buildIndividualItem("Haemostatic sets", 21),
              buildIndividualItem("Emergency medicines", 22),
              buildIndividualItem("Travelling Ventilator", 23),
              buildIndividualItem("Chest drainage tubes", 24),
              buildIndividualItem("Others", 25),
              const Divider(
                thickness: 3.0,
              ),
              buildIndividualItem("Washing equipment", 26),
              buildIndividualItem("Wheelchair and trolley", 27),
              buildIndividualItem("Radio communication", 28),
              buildIndividualItem("Two-way video consultation device", 29),
              buildIndividualItem("Mobile device with 4G connectivity", 30),
              buildIndividualItem("Walkie Talkie", 31),
              buildIndividualItem("Camera", 32),
              buildIndividualItem("GPS (Geographical Positioning System)", 33),
              const Divider(
                thickness: 3.0,
              ),
              TextField(
                controller: _medicineController,
                decoration: const InputDecoration(
                  labelText: "Medicines",
                  prefixIcon: Icon(Icons.medication),
                ),
              ),
              InputDecorator(
                decoration: const InputDecoration(
                  label: Text("Accept Status*"),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            const Text("Accept: "),
                            Obx(
                              () => Radio(
                                value: AcceptStatus.accept,
                                groupValue: _acceptStatus.value,
                                onChanged: (AcceptStatus? value) {
                                  count = 9;
                                  _acceptStatus.value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text("Reject:"),
                            Obx(
                              () => Radio(
                                value: AcceptStatus.reject,
                                groupValue: _acceptStatus.value,
                                onChanged: (AcceptStatus? value) {
                                  count = int.parse(
                                          ambulance.formLevel.toString()) +
                                      1;
                                  _acceptStatus.value = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Obx(
                      () => (_acceptStatus.value == AcceptStatus.reject)
                          ? TextField(
                              controller: _rejectedMessageController,
                              decoration: const InputDecoration(
                                label: Text("Reason For reject* "),
                              ),
                            )
                          : const SizedBox(),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () async {
                  if (validateInput()) {
                    Utilities.showAlertDialog(context, "Please wait", "");
                    var assignedData = assignValue();
                    var data = await Get.find<AdminController>()
                        .postAdminForm(assignedData);
                    Get.back();
                    if (data) {
                      Get.close(1); // go back 2 step
                    }
                  } else {
                    Utilities.showToast("All * field are required",
                        toastType: ToastType.error);
                  }
                },
                child: const Text("Submit"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum AcceptStatus { accept, reject, none }
