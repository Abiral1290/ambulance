import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Constants {
  static String loginType = "";
  static Color color = Colors.green[900]!;

  static BitmapDescriptor? ambulanceIcon;

  // ambulance trip
  static String? selectedDeviceId; //for public to show in map
  static String? selectedDriverNumber; //for public to show in map
  static String? selectedDriverName; //for public to show in map
  static var isRequestedForVehicle = false.obs; //for public
  static var isTripAccepted = false.obs; //for public
  static String requestId = 0.toString();

  static var isTripStarted = false.obs; // for driver
  static var isTripEnded = false.obs; // for driver

  // for FCM
  static const String request = "request";
  static const String response = "response";
  static const String trip = "trip";

  // vehicle status
  static const String available = "avaliable";
  static const String busy = "busy";

  static const String driver = "driver";
  static const String public = "public";
  static const String admin = "admin";
  static const String traffic = "traffic";

  static const double borderRadius = 12.0;
  static const double verticalPadding = 10.0;

  static const googleAPIKey = "AIzaSyC_siAOGtkjHJ4i_1SzyjaSV8VC83vfYAw";
}
