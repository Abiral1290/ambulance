import 'dart:convert';
import 'dart:io';

import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ToastType {
  static const String success = "success";
  static const String info = "info";
  static const String error = "error";
}

class Utilities {
  static showToast(String message, {String toastType = ToastType.info}) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.CENTER,
      textColor: Colors.white,
      backgroundColor: toastType == ToastType.success
          ? Colors.green[900]
          : toastType == ToastType.error
              ? Colors.red[900]
              : Colors.yellow[900],
    );
  }

  static showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        builder: (builder) {
          return AlertDialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(body),
                const CircularProgressIndicator(),
              ],
            ),
          );
        });
  }

  static Future<bool> showConfirmationDialog(
      BuildContext context, String title, String body) async {
    bool confirm = false;
    await showDialog(
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        builder: (builder) {
          return AlertDialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
            title: Text(title),
            actions: [
              TextButton(
                  onPressed: () {
                    confirm = true;
                    Get.back(result: true);
                  },
                  child: const Text("Confirm")),
              TextButton(
                  onPressed: () {
                    confirm = false;
                    Get.back(result: false);
                  },
                  child: const Text("Decline")),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(body),
              ],
            ),
          );
        });
    return confirm;
  }

  static Future<bool> showRequestDialog(
      BuildContext context, String title, String name, String injury) async {
    bool confirm = false;
    await showDialog(
        barrierDismissible: false,
        barrierColor: Colors.grey.withOpacity(0.5),
        context: context,
        builder: (builder) {
          return AlertDialog(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
            title: Text(title),
            actions: [
              TextButton(
                  onPressed: () {
                    confirm = true;
                    Get.back(result: true);
                  },
                  child: const Text("Accept")),
              TextButton(
                  onPressed: () {
                    confirm = false;
                    Get.back(result: false);
                  },
                  child: const Text("Decline")),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Patient Name: ",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Expanded(child: Text(name)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Injury: ",
                      style: TextStyle(fontSize: 17.0),
                    ),
                    Expanded(child: Text(injury)),
                  ],
                ),
              ],
            ),
          );
        });
    return confirm;
  }

  static Future<bool> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }

  static String encodeToBase64(File file) {
    final bytes = file.readAsBytesSync();

    String base64 = base64Encode(bytes);
    return base64;
  }

  static Image decodeBase64(String base64) {
    final decodeBytes = base64Decode(base64);

    return Image.memory(decodeBytes);
  }

  static getUserTypeColor() {
    switch (Get.find<AuthController>().userType!.toLowerCase()) {
      case Constants.admin:
        Constants.color = Colors.red[900]!;
        break;
      case Constants.public:
        Constants.color = Colors.green[900]!;
        break;
      case Constants.driver:
        Constants.color = Colors.amber[900]!;
        break;
      case Constants.traffic:
        Constants.color = Colors.lightBlue[900]!;
        break;
      default:
    }
  }

  static logout() {
    if (Get.find<AuthController>().userType!.toLowerCase() ==
        Constants.driver.toLowerCase()) {
      Get.close(1);
    }
    Get.find<AuthController>().signout();
  }
}
