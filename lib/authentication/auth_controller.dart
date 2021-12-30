import 'dart:convert';

import 'package:ambulance_nepal/driver/driver.dart';
import 'package:ambulance_nepal/services/firebase_services.dart';
import 'package:ambulance_nepal/services/preference_services.dart';
import 'package:ambulance_nepal/authentication/user.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  PreferenceService preferenceService = PreferenceService();
  final FirebaseServices _firebaseServices = FirebaseServices();

  bool isLoggedIn = false;

  String? userType;
  String fcmToken = "";

  Users? users;

  dynamic userProfile;

  @override
  void onInit() {
    getFcmToken();
    getLoggedInData();
    super.onInit();
  }

  getFcmToken() async {
    fcmToken = await _firebaseServices.getToken();
    update();
  }

  loginUser(
      String phone, String password, String role, String firebaseToken) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      loginApi(phone, password, role, firebaseToken).then((value) {
        Utilities.showToast(value.message);
        if (value.success) {
          var data = json.encode(value.response!.toPreference());
          preferenceService.saveUser(data);
          isLoggedIn = true;
          userType = value.response!.userType;
          users = value.response;
          Utilities.getUserTypeColor();
          Get.close(2);
          update();
        } else {
          Get.back();
        }
      });
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
    }
  }

  Future<bool> registerUser(Users user) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      var data = await registerApi(user);
      Utilities.showToast(data.message);
      return data.success;
    } else {
      Utilities.showToast("No internet connection", toastType: ToastType.error);
      return false;
    }
  }

  getLoggedInData() {
    preferenceService.getUser().then((value) {
      if (value != null) {
        isLoggedIn = true;
        users = Users.fromJson(json.decode(value));
        userType = users!.userType;
        Utilities.getUserTypeColor();
        print(users!.apiToken);
        print(users!.firebaseToken);
        update();
      }
    });
  }

  changePassword(String oldPassword, String newPassword) async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      changePasswordApi(oldPassword, newPassword).then((value) {
        Utilities.showToast(value.message);
        Get.close(2);
        if (value.success) {
          Utilities.logout();
        }
      });
    } else {
      Utilities.showToast("No INternet Connection", toastType: ToastType.error);
    }
  }

  getProfile() async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      getProfileApi().then((value) {
        Utilities.showToast(value.message);
        print(value);
        if (value.success) {
          if (users!.userType!.toLowerCase() == Constants.driver) {
            userProfile = Driver.fromJson(value.response);
            update();
          } else {
            userProfile = Users.fromJson(value.response);
            update();
          }
          return value.response;
        } else {
          return null;
        }
      });
    } else {
      Utilities.showToast("No Internet Connection", toastType: ToastType.error);
      return null;
    }
  }

  signout() async {
    var conn = await Utilities.checkInternetConnection();
    if (conn) {
      logoutApi().then((value) {
        Utilities.showToast(value.message);
        if (value.success) {
          clearAllData();
        }
      });
    }
  }

  clearAllData() {
    preferenceService.clear();
    userType = null;
    users = null;
    isLoggedIn = false;
    update();
  }
}
