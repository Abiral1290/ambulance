import 'package:ambulance_nepal/map/devices/devices.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class DeviceController extends GetxController {
  var devicesList = [].obs;
  var device = Devices().obs;

  Future<List<Devices>> fetchDevice(String latitude, String longitude) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var value = await fetchDeviceApi(latitude, longitude);
      if (value.success) {
        devicesList.value = value.response!;
        update();
        return value.response!;
      } else {
        Utilities.showToast(value.message, toastType: ToastType.error);
        return [];
      }
    } else {
      Utilities.showToast("No Internet", toastType: ToastType.info);
      return [];
    }
  }

  Future<Devices?> fetchSelectedDevice(String uniqueId) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var value = await fetchIndividualDeviceApi(uniqueId);
      if (value.success) {
        device.value = value.response!;
        update();
        return value.response!;
      } else {
        Utilities.showToast(value.message, toastType: ToastType.error);
        return null;
      }
    } else {
      Utilities.showToast("No Internet", toastType: ToastType.info);
      return null;
    }
  }
}
