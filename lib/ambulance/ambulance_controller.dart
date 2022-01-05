import 'package:ambulance_nepal/ambulance/ambulance.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class AmbulanceController extends GetxController {
  List<Ambulance> ambulanceList = [];
  List<Ambulance> searchedAmbulanceList = [];

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

  searchAmbulance(String text) {
    searchedAmbulanceList = ambulanceList
        .where((element) => (element.vehicleName!
                .trim()
                .toLowerCase()
                .contains(text.trim().toLowerCase()) ||
            element.vehicleNumber!.toLowerCase().contains(text.toLowerCase())))
        .toList();
    print(searchedAmbulanceList);
    update();
  }

  clearSearch() {
    searchedAmbulanceList = [];
    update();
  }
}
