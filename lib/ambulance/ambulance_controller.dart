import 'package:ambulance_nepal/ambulance/ambulance.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class AmbulanceController extends GetxController {
  List<Ambulance> ambulanceList = [];

  @override
  onInit() {
    getAmbulance();
    super.onInit();
  }

  getAmbulance() async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      getAmbulanceApi().then((value) {
        Utilities.showToast(value.message);
        if (value.success) {
          ambulanceList = value.response!;
          update();
        }
      });
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
    }
  }
}
