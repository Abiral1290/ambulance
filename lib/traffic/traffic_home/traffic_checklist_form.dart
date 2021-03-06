import 'package:ambulance_nepal/traffic/traffic_controller.dart';
import 'package:ambulance_nepal/traffic/traffic_checklist.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nepali_date_picker/nepali_date_picker.dart' as picker;

// ignore: must_be_immutable
class TrafficChecklistFormPage extends StatelessWidget {
  TrafficChecklistFormPage({Key? key}) : super(key: key);
  TrafficForm trafficForm = TrafficForm();

  var checked = List.generate(20, (index) => false).obs;

  List<TextEditingController> controllers =
      List.generate(26, (index) => TextEditingController());

  var ambulanceStartDateController = TextEditingController().obs;
  TextEditingController driverNameController = TextEditingController();
  TextEditingController driverPhoneController = TextEditingController();

  InputDecoration titleDecoration(String title) {
    return InputDecoration(
      label: Text(title),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
    );
  }

  InputDecoration textDecoration(String title) {
    return InputDecoration(
      label: Text(title),
    );
  }

  bool validateInput() {
    return ambulanceStartDateController.value.text.isNotEmpty &&
        driverNameController.text.isNotEmpty &&
        driverPhoneController.text.isNotEmpty &&
        controllers[19].text.isNotEmpty &&
        controllers[20].text.isNotEmpty &&
        controllers[21].text.isNotEmpty &&
        controllers[22].text.isNotEmpty;
  }

  _handleSubmit(BuildContext context) {
    if (validateInput()) {
      Utilities.showAlertDialog(context, "Please wait", "");

      assignValue();
    } else {
      Utilities.showToast("Please Fill all required fields",
          toastType: ToastType.error);
    }
  }

  assignValue() async {
    trafficForm.ambulanceBluebook =
        checked[0].toString() + "//" + controllers[0].text;
    trafficForm.driverLicense =
        checked[1].toString() + "//" + controllers[1].text;
    trafficForm.ambulancePermisision =
        checked[2].toString() + "//" + controllers[2].text;
    trafficForm.ambulanceRenew =
        checked[3].toString() + "//" + controllers[3].text;
    trafficForm.taxFreeClearification =
        checked[4].toString() + "//" + controllers[4].text;
    trafficForm.standardColor =
        checked[5].toString() + "//" + controllers[5].text;
    trafficForm.bigWord102 = checked[6].toString() + "//" + controllers[6].text;
    trafficForm.starOfLightLogoLeftRightBehind =
        checked[7].toString() + "//" + controllers[7].text;
    trafficForm.gps = checked[8].toString() + "//" + controllers[8].text;
    trafficForm.standardSairan =
        checked[9].toString() + "//" + controllers[9].text;
    trafficForm.ambulanceType =
        checked[10].toString() + "//" + controllers[10].text;
    trafficForm.cUpgardeToAB =
        checked[11].toString() + "//" + controllers[11].text;
    trafficForm.fourWheeler =
        checked[12].toString() + "//" + controllers[12].text;
    trafficForm.pricelistInSeenArea =
        checked[13].toString() + "//" + controllers[13].text;
    trafficForm.noSeatBehindDriver =
        checked[14].toString() + "//" + controllers[14].text;
    trafficForm.ambulanceStartedDate = ambulanceStartDateController.value.text;
    trafficForm.trainedHealthWorker = checked[15].toString() +
        "//" +
        controllers[15].text +
        "//" +
        controllers[16].text;
    trafficForm.driverAge25 =
        checked[16].toString() + "//" + controllers[17].text;
    trafficForm.ambulanceDrivingTranning =
        checked[17].toString() + "//" + controllers[18].text;
    trafficForm.driverName = driverNameController.text;
    trafficForm.driverNumber = driverPhoneController.text;
    trafficForm.examinatedLocation = controllers[19].text;
    trafficForm.examinatedDatetime = controllers[20].text;
    trafficForm.punishment = controllers[21].text;
    trafficForm.trafficeNameNumber = controllers[22].text;
    print(trafficForm);
    var data = await Get.find<TrafficController>().postTrafficForm(trafficForm);
    Get.back();
    if (data) {
      Get.close(1); // go back 2 step
    }
  }

  Widget licenseCategory() {
    return InputDecorator(
      decoration: titleDecoration("???????????????????????? ??? ?????????????????????"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("???????????????????????????????????? ??????????????????????????? ????????????????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[0],
                    onChanged: (value) {
                      checked[0] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[0],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????????????????? ?????????????????? ???????????????????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[1],
                    onChanged: (value) {
                      checked[1] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[1],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget permissionCategory() {
    return InputDecorator(
      decoration: titleDecoration("?????????????????? ??? ??????????????????"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "????????????????????? ????????? ???????????????????????? ???????????????????????????????????? ????????????????????? ?????????????????????????????? ???????????? ???????????????????????? ?????????????????? ???????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[2],
                    onChanged: (value) {
                      checked[2] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[2],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "??????????????????????????? ?????????????????????????????? ?????????????????????????????? ???????????????????????? ?????????????????? ????????????  "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[3],
                    onChanged: (value) {
                      checked[3] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[3],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget standardCategory(BuildContext context) {
    return InputDecorator(
      decoration: titleDecoration("?????????????????????"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "??????????????? ???????????????????????? ?????????????????? ????????? ???????????????????????? ???????????????????????? ??????????????? ?????? ?????? ???????????? ???????????????????????????????????? ?????????????????? ??????????????? ?????????????????? ?????????????????? ????????? ????????????????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[4],
                    onChanged: (value) {
                      checked[4] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[4],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("???????????????????????????????????? ????????????????????? ?????????????????? ????????????????????????  "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[5],
                    onChanged: (value) {
                      checked[5] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[5],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("???????????????????????????????????? ??????????????? ???????????? ????????????????????? ????????????????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[6],
                    onChanged: (value) {
                      checked[6] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[6],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "??????????????? ?????? ???????????? ??????????????? ??????????????? ???????????????, ??????????????? ??? ??????????????? ????????? ???????????? ???????????? "),
              ),
              Obx(
                () => Checkbox(
                    value: checked[7],
                    onChanged: (value) {
                      checked[7] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[7],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("GPS ???????????? ?????? ?????????????????? ?????????????????????????????? ?????????????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[8],
                    onChanged: (value) {
                      checked[8] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[8],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("????????? ?????? ?????? ??????????????? ??? ?????? (???) ?????????????????? ??????????????? ????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[9],
                    onChanged: (value) {
                      checked[9] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[9],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("???????????????????????????????????? ???????????? ??? ?????? ??? ??????????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[10],
                    onChanged: (value) {
                      checked[10] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[10],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "????????? ?????????????????? ?????????????????? ?????????????????? ????????????????????? ?????????????????? ??????????????? ????????? ?????? ????????? ???????????????????????? ?????????????????????????????? ???????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[11],
                    onChanged: (value) {
                      checked[11] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[11],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("???????????? 4WD ????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[12],
                    onChanged: (value) {
                      checked[12] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[12],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "???????????????????????????????????? ???????????? ???????????? ??????????????? ?????????????????? ??????????????? ??????????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[13],
                    onChanged: (value) {
                      checked[13] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[13],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "???????????????????????????????????? ?????????????????? ??????????????? ??????????????? ???????????? ????????? ????????? ????????????????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[14],
                    onChanged: (value) {
                      checked[14] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[14],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????????????????? ???????????????????????? ???????????? ???????????? ????????????:"),
              ),
              SizedBox(
                width: Get.size.width * 0.4,
                child: Obx(
                  () => TextField(
                    readOnly: true,
                    controller: ambulanceStartDateController.value,
                    decoration: textDecoration("????????????: *"),
                    onTap: () async {
                      picker.NepaliDateTime? selectedDateTime =
                          await picker.showAdaptiveDatePicker(
                        context: context,
                        initialDate: picker.NepaliDateTime.now()
                            .subtract(const Duration(days: 9125)),
                        firstDate: picker.NepaliDateTime(1970),
                        lastDate: picker.NepaliDateTime(2100),
                        language: picker.Language.nepali,
                      );

                      if (selectedDateTime != null) {
                        var differenceInDays = (picker.NepaliDateTime.now()
                                .difference(selectedDateTime)
                                .inHours /
                            24);

                        var differenceInYears =
                            (differenceInDays / 365).round();
                        ambulanceStartDateController.value.text =
                            picker.NepaliDateFormat.yMd()
                                    .format(selectedDateTime) +
                                " ($differenceInYears years)";
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("??????????????? ????????????????????? ?????????????????????????????????????????? ??????:"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[15],
                    onChanged: (value) {
                      checked[15] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controllers[15],
                      decoration: textDecoration("?????????:"),
                    ),
                    TextField(
                      controller: controllers[16],
                      decoration: textDecoration("????????????????????? ??????:"),
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget driverCategory() {
    return InputDecorator(
      decoration: titleDecoration("????????????"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????????????????? ?????????????????? ???????????? ?????? ??????????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[16],
                    onChanged: (value) {
                      checked[16] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[17],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child:
                    const Text("?????????????????? ?????????????????????????????? ?????????????????? ???????????????????????? ??????????????? ???????????????"),
              ),
              Obx(
                () => Checkbox(
                    value: checked[17],
                    onChanged: (value) {
                      checked[17] = value!;
                    }),
              ),
              SizedBox(
                width: Get.size.width * 0.35,
                child: TextField(
                  controller: controllers[18],
                  decoration: textDecoration("??????????????????"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????????????????? ?????????????????? ?????????: "),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: driverNameController,
                  decoration: textDecoration("?????????????????? ?????????: *"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????????????????? ?????????????????? ????????????????????? ???????????????: "),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: driverPhoneController,
                  decoration: textDecoration("?????????????????? ????????????????????? ???????????????: *"),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget otherCategory() {
    return InputDecorator(
      decoration: titleDecoration("???????????????, ???????????? ??? ????????????"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????? ?????????????????? ???????????????:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[19],
                  decoration: textDecoration("?????????????????? *"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("?????????????????? ?????????????????? ????????????/?????????:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[20],
                  decoration: textDecoration("?????????????????? *"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "??????????????????????????? ?????????????????? (????????? ??????????????????????????? ??????????????? ?????????????????? ??????):"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[21],
                  decoration: textDecoration("?????????????????? *"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child:
                    const Text("?????????????????? ??????????????? ????????????????????? ???????????????????????? ????????? ??? ?????????????????????:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[22],
                  decoration: textDecoration("?????????????????? *"),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
        ],
      ),
    );
  }

  Widget submitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        FocusScope.of(context).requestFocus(FocusNode());

        _handleSubmit(context);
      },
      child: const Text("Submit"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(const Text(
        "Ambulance Checklist",
        style: TextStyle(color: Colors.black),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Column(
            children: [
              const Text(
                  "??????????????? ???????????????????????? ????????????????????????????????????????????? ?????????????????? ?????????????????? ??????????????? ?????????????????? ??????????????? ????????????????????????"),
              const SizedBox(
                height: 20.0,
              ),
              licenseCategory(),
              const SizedBox(
                height: 10.0,
              ),
              permissionCategory(),
              const SizedBox(
                height: 10.0,
              ),
              standardCategory(context),
              const SizedBox(
                height: 10.0,
              ),
              driverCategory(),
              const SizedBox(
                height: 10.0,
              ),
              otherCategory(),
              const SizedBox(
                height: 10.0,
              ),
              submitButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
