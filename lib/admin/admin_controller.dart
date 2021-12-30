import 'package:ambulance_nepal/admin/admin_checklist.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class AdminController extends GetxController {
  Future<bool> postAdminForm(AdminChecklist adminForm) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var response = await postAdminFormApi(adminForm);
      Utilities.showToast(response.message);
      return response.success;
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
      return false;
    }
  }
}
