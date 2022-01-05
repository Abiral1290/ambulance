import 'package:ambulance_nepal/hospitals/hospitals.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class HospitalsController extends GetxController {
  List<Hospitals> hospitalList = [];
  Hospitals? selectedHospital;

  @override
  onInit() {
    fetchHospitals();
    super.onInit();
  }

  setSelectedHospital(Hospitals hospitals) {
    selectedHospital = hospitals;
    update();
  }

  Hospitals getUserHospital(String hospitalId) {
    var list =
        hospitalList.where((element) => element.id.toString() == hospitalId);
    return list.first;
  }

  fetchHospitals() async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      fetchHospitalsApi().then((value) {
        if (value.success) {
          hospitalList = value.response!;
          selectedHospital = hospitalList.first;
          update();
        } else {
          Utilities.showToast(value.message, toastType: ToastType.error);
        }
      });
    } else {
      Utilities.showToast("No internet connection", toastType: ToastType.info);
    }
  }
}
