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
      decoration: titleDecoration("लाइसेन्स र ब्लुबुक"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("एम्बुलेन्सको अद्यावधिक ब्लुबुक "),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("एम्बुलेन्स चालकको लाइसेन्स "),
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
                  decoration: textDecoration("कैफियत"),
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
      decoration: titleDecoration("अनुमति र नबिकरण"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "स्वास्थ तथा जनसंख्या मन्त्रालयबाट प्राप्त एम्बुलेन्स सेवा संचालनको अनुमति पत्र "),
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
                  decoration: textDecoration("कैफियत"),
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
                    "प्रादेशिक एम्बुलेन्स व्यवस्थापन समितिबाट नबिकरण पत्र  "),
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
                  decoration: textDecoration("कैफियत"),
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
      decoration: titleDecoration("मापदण्ड"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text(
                    "नेपाल सरकारबाट राजश्व छुट सुबिधामा प्राप्त” गरेको भए सो कुरा एम्बुलेन्सको बाहिरी पट्टी प्रष्ट देखिने गरि लेखिएको "),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("निर्देशिकाको मापदण्ड अनुसार रंगाईएको  "),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("एम्बुलेन्समा “१०२” ठुलो अक्षरमा लेखिएको "),
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
                  decoration: textDecoration("कैफियत"),
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
                    "स्टार अफ लाइफ संकेत चिन्ह दायाँ, बायाँ र पछाडी तीन तर्फ भएको "),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("GPS जडान भई प्रेषण केन्द्रसंग जोडिएको"),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("दफा १५ को उपदफा १ को (ख) अनुसार साइरन भएको"),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("एम्बुलेन्सको वर्ग क वा ख खुलेको"),
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
                  decoration: textDecoration("कैफियत"),
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
                    "“ग” वर्गमा संचालन अनुमति पाएकोले नविकरण गर्दा “क” वा “ख” वर्गमामा स्तरोन्नति गरेको"),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("गाडी 4WD भएको"),
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
                  decoration: textDecoration("कैफियत"),
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
                    "एम्बुलेन्सको सेवा सेवा शुल्क देखिने ठाउमा टासेको"),
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
                  decoration: textDecoration("कैफियत"),
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
                    "एम्बुलेन्सको चालकको पछाडि पट्टी कुनै पनि सिट नराखिएको"),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("एम्बुलेन्स संचालनमा आएको अवधि मिति:"),
              ),
              SizedBox(
                width: Get.size.width * 0.4,
                child: Obx(
                  () => TextField(
                    readOnly: true,
                    controller: ambulanceStartDateController.value,
                    decoration: textDecoration("मिति: *"),
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
                child: const Text("तालिम प्राप्त स्वास्थ्यकर्मी भए:"),
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
                      decoration: textDecoration("नाम:"),
                    ),
                    TextField(
                      controller: controllers[16],
                      decoration: textDecoration("सम्पर्क नं:"),
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
      decoration: titleDecoration("चालक"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("एम्बुलेन्स चालकको उमेर २५ पुगेको"),
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
                  decoration: textDecoration("कैफियत"),
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
                    const Text("चालकले एम्बुलेन्स संचालन सम्बन्धि तालिम लिएको"),
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
                  decoration: textDecoration("कैफियत"),
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
                child: const Text("एम्बुलेन्स चालकको नाम: "),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: driverNameController,
                  decoration: textDecoration("चालकको नाम: *"),
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
                child: const Text("एम्बुलेन्स चालकको सम्पर्क नम्बर: "),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: driverPhoneController,
                  decoration: textDecoration("चालकको सम्पर्क नम्बर: *"),
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
      decoration: titleDecoration("स्थान, मिति र अन्य"),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.size.width * 0.35,
                child: const Text("चेकजाच गरिएको स्थान:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[19],
                  decoration: textDecoration("कैफियत *"),
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
                child: const Text("चेकजाच गरिएको मिति/समय:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[20],
                  decoration: textDecoration("कैफियत *"),
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
                    "कार्यबाही निर्णय (यदि कार्यबाही गर्ने अवस्था भए):"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[21],
                  decoration: textDecoration("कैफियत *"),
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
                    const Text("चेकजाच गर्ने ट्राफिक प्रहरीको नाम र सम्पर्क:"),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: Get.size.width * 0.45,
                child: TextField(
                  controller: controllers[22],
                  decoration: textDecoration("कैफियत *"),
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
                  "राफिक प्रहरीले एम्बुलेन्सहरूको नियमित चेकजाच गर्दा प्रयोग गर्ने चेकलिस्ट"),
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
