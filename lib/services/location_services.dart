import 'dart:async';

import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class LocationServices extends GetxController {
  final Location location = Location();

  LocationData? locationData;
  StreamSubscription<LocationData>? _locationSubscription;

  @override
  onInit() {
    initFunction();
    super.onInit();
  }

  initFunction() {
    checkLocation();
  }

  Future<void> _listenLocation() async {
    _locationSubscription =
        location.onLocationChanged.handleError((dynamic err) {
      if (err is PlatformException) {}
      _locationSubscription?.cancel();

      _locationSubscription = null;
    }).listen((LocationData currentLocation) {
      locationData = currentLocation;
      update();
      location.changeNotificationOptions(
          onTapBringToFront: true,
          title: "Location Service is running in background",
          subtitle: "${locationData!.latitude}, ${locationData!.longitude}");
    });
  }

  Future<void> stopListen() async {
    _locationSubscription?.cancel();

    _locationSubscription = null;
  }

  checkLocation() async {
    bool _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      Utilities.showToast('Please enable location!', toastType: ToastType.info);
      await location.requestService().then((value) {
        if (value) {
          checkAndRequestPermission();
        }
      });
    } else {
      checkAndRequestPermission();
    }
  }

  checkAndRequestPermission() async {
    var isBackground = await location.isBackgroundModeEnabled();
    await location.hasPermission().then((value) {
      if (value == PermissionStatus.granted ||
          value == PermissionStatus.grantedLimited) {
        _listenLocation();

        // to fetch location in background
        if (!isBackground) {
          location.enableBackgroundMode(enable: true);
        }
      } else if (value == PermissionStatus.denied ||
          value == PermissionStatus.deniedForever) {
        location.requestPermission().then((value) {
          if (value == PermissionStatus.granted ||
              value == PermissionStatus.grantedLimited) {
            _listenLocation();

            // to fetch location in background
            if (!isBackground) {
              location.enableBackgroundMode(enable: true);
            }
          } else if (value == PermissionStatus.denied ||
              value == PermissionStatus.deniedForever) {
            Utilities.showToast(
                "Permission denied. Please enable location permission",
                toastType: ToastType.error);
          }
        });
      }
    });
  }
}
