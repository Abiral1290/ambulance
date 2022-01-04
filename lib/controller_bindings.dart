import 'package:ambulance_nepal/admin/admin_controller.dart';
import 'package:ambulance_nepal/ambulance/ambulance_controller.dart';
import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/driver/driver_controller.dart';
import 'package:ambulance_nepal/map/devices/device_controller.dart';
import 'package:ambulance_nepal/services/location_services.dart';
import 'package:ambulance_nepal/services/preference_services.dart';
import 'package:ambulance_nepal/traffic/traffic_controller.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationServices(), permanent: true);
    Get.put(PreferenceService(), permanent: true);
    Get.put(AuthController(), permanent: true);
    Get.lazyPut(() => DriverController());
    Get.lazyPut(() => TrafficController());
    Get.lazyPut(() => AdminController());
    Get.lazyPut(() => DeviceController());
    Get.lazyPut(() => VehicleRequestController());
    Get.lazyPut(() => AmbulanceController());
  }
}
