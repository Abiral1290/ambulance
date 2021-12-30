import 'package:ambulance_nepal/traffic/traffic_checklist.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class TrafficController extends GetxController {
  Future<bool> postTrafficForm(TrafficForm trafficForm) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await postTrafficFormApi(trafficForm);
      Utilities.showToast(response.message);
      return response.success;
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
      return false;
    }
  }
}
