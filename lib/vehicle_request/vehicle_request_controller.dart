import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/vehicle_request/vehicle_request.dart';
import 'package:get/get.dart';

class VehicleRequestController extends GetxController {
  Future<bool> sendRequest(VehicleRequest vehicleRequest) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await sendRequestApi(vehicleRequest);
      Utilities.showToast(response.message, toastType: ToastType.info);
      return response.success;
    } else {
      Utilities.showToast("No Internet!", toastType: ToastType.error);
      return false;
    }
  }

  Future<bool> sendResponse(String respons, String requestId) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await sendResponseApi(respons, requestId);
      Utilities.showToast(response.message, toastType: ToastType.info);
      return response.success;
    } else {
      Utilities.showToast("No Internet!", toastType: ToastType.error);
      return false;
    }
  }
}
