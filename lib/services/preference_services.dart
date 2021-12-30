import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService extends GetxController {
  String login = "login";
  String user = "user";

  clear() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    await _preferences.clear();
  }

  saveUser(String userData) async {
    try {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      _preferences.setString(user, userData);
    } catch (e) {
      print("failed to store user: " + e.toString());
    }
  }

  Future<String?> getUser() async {
    try {
      SharedPreferences _preferences = await SharedPreferences.getInstance();
      var data = _preferences.getString(user);
      return data;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
