import 'package:ambulance_nepal/hospitals/hospitals_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class ViewHospitalPage extends StatelessWidget {
  ViewHospitalPage({Key? key}) : super(key: key);

  var controller = Get.put(HospitalsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Hospitals",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
      body: GetBuilder<HospitalsController>(builder: (builder) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.verticalPadding),
          child: ListView.builder(
            itemCount: Get.find<HospitalsController>().hospitalList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Text((index + 1).toString()),
                title: Text(Get.find<HospitalsController>()
                    .hospitalList[index]
                    .hospitalName!),
              );
            },
          ),
        );
      }),
    );
  }
}
