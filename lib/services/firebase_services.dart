import 'dart:async';

import 'package:ambulance_nepal/driver/driver_home/driver_map.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("FCM background initailized");

  handleNotification(message);
}

handleNotification(RemoteMessage message) async {
  if (message.data["notification_type"] == "request") {
    // for new vehicle request
    Constants.requestId = message.data["request_id"].toString();
    var response = await Utilities.showRequestDialog(
      Get.context!,
      message.notification!.title.toString(),
      message.data["patient_name"],
      message.data["patient_injury_type"],
    );
    if (response) {
      Utilities.showToast("Request Accepted");
      Get.find<VehicleRequestController>()
          .sendResponse("1", message.data["request_id"].toString())
          .then((value) {
        if (value) {
          Get.to(
            () => DriverMapPage(
              lat: double.parse(message.data["lat"].toString()),
              long: double.parse(message.data["long"].toString()),
              patientName: message.data["patient_name"].toString(),
              name: message.data["name"].toString(),
              number: message.data["number"].toString(),
              injuryType: message.data["patient_injury_type"].toString(),
              requestId: message.data["request_id"].toString(),
            ),
          );
        }
      });
    } else {
      Get.find<VehicleRequestController>()
          .sendResponse("2", message.data["request_id"].toString())
          .then((value) {
        if (value) {
          Utilities.showToast("Request Rejected");
        }
      });
    }
  } else if (message.data["notification_type"] == "response") {
    if (message.data["response"] == "1") {
      // accepted
      Constants.isTripAccepted.value = true;
      Constants.selectedDeviceId = message.data["device_uniqueid"];
      Constants.selectedDriverName = message.data["name"];
      Constants.selectedDriverNumber = message.data["number"];
    } else if (message.data["response"] == "2") {
      // rejected
      Constants.isRequestedForVehicle.value = false;
      Utilities.showToast("Your request has been rejected");
    }
  } else if (message.data["notification_type"] == "start_trip") {
    //start trip for passenger
    Constants.isTripStarted.value = true;
  } else if (message.data["notification_type"] == "end_trip") {
    //end trip for passenger
    Constants.isTripEnded.value = true;
    Constants.isTripStarted.value = false;
    Constants.isTripAccepted.value = false;
    Constants.isRequestedForVehicle.value = false;
  } else {
    Utilities.showAlertDialog(
        Get.context!,
        message.notification!.title.toString(),
        message.notification!.body.toString());
  }
}

class FirebaseServices extends GetxController {
  FirebaseMessaging _messaging = FirebaseMessaging.instance;

  @override
  void onInit() {
    registerNotification();
    super.onInit();
  }

  void registerNotification() async {
    print("Notification registered");
    _messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
      FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);

      FirebaseMessaging.onMessage.listen(
        (message) async {
          print("Message came");
          handleNotification(message);
        },
      );
      FirebaseMessaging.onMessageOpenedApp.listen((message) {
        print(message);
        handleNotification(message);
      });
    } else {
      Utilities.showToast('User declined or has not accepted permission',
          toastType: ToastType.info);
    }
  }

  Future<String> getToken() async {
    return await _messaging.getToken() ?? "";
  }
}
