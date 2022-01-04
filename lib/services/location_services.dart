import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:location/location.dart';

class LocationServices extends GetxController {
  Position? locationData;

  @override
  onInit() {
    initFunction();
    super.onInit();
  }

  initFunction() {
    checkLocation();
  }

  checkLocation() async {
    bool isLocationOpened = await Geolocator.isLocationServiceEnabled();

    if (!isLocationOpened) {
      Utilities.showToast('Please enable location!', toastType: ToastType.info);
      await Geolocator.openLocationSettings().then((value) {
        if (value) {
          checkAndRequestPermission();
        }
      });
    } else {
      checkAndRequestPermission();
    }
  }

  getPositionStream() async {
    Geolocator.getPositionStream().listen((Position position) async {
      locationData = position;
      update();
    });
  }

  getCurrentPosition() {
    Geolocator.getCurrentPosition().then((value) {
      locationData = value;
      update();
    });
  }

  checkAndRequestPermission() async {
    await Geolocator.checkPermission().then((value) {
      if (value == LocationPermission.always ||
          value == LocationPermission.whileInUse) {
        getCurrentPosition();
        getPositionStream();
      } else if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever) {
        Geolocator.requestPermission().then((value) {
          if (value == LocationPermission.always ||
              value == LocationPermission.whileInUse) {
            getCurrentPosition();
            getPositionStream();
          } else if (value == LocationPermission.denied ||
              value == LocationPermission.deniedForever) {
            Utilities.showToast(
                "Permission denied. Please enable location permission",
                toastType: ToastType.error);
          }
        });
      }
    });
  }
}
