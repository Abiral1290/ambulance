import 'package:ambulance_nepal/utils/constants.dart';
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

  Future<bool> sendStartTrip(String requestId, String tripStartTime) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await sendStartTripApi(requestId, tripStartTime);
      Utilities.showToast(response.message, toastType: ToastType.info);
      return response.success;
    } else {
      Utilities.showToast("No Internet!", toastType: ToastType.error);
      return false;
    }
  }

  Future<bool> sendEndTrip(
      String requestId, String tripEndTime, String lat, String long) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await sendEndTripApi(requestId, tripEndTime, lat, long);
      Utilities.showToast(response.message, toastType: ToastType.info);
      if (response.success)
        // ignore: curly_braces_in_flow_control_structures
        Constants.requestId = 0.toString(); // setting request id to 0
      return response.success;
    } else {
      Utilities.showToast("No Internet!", toastType: ToastType.error);
      return false;
    }
  }
}
