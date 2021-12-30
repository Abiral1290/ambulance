import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);

  var switchValue = false.obs;

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void showChangePasswordBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Padding(
        padding: const EdgeInsets.all(Constants.verticalPadding),
        child: Container(
          height: Get.size.height * 0.35,
          width: Get.size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(Constants.verticalPadding),
            child: Column(
              children: [
                TextField(
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.borderRadius),
                    ),
                    label: const Text("Old Password"),
                  ),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                TextField(
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.borderRadius),
                    ),
                    label: const Text("New Password"),
                  ),
                ),
                SizedBox(
                  height: Get.size.height * 0.02,
                ),
                MaterialButton(
                  onPressed: () {
                    if (_oldPasswordController.text.isNotEmpty &&
                        _newPasswordController.text.isNotEmpty) {
                      if (_oldPasswordController.text.trim() !=
                          _newPasswordController.text.trim()) {
                        Utilities.showAlertDialog(
                            context, "Please wait", "Performing operation");
                        Get.find<AuthController>().changePassword(
                            _oldPasswordController.text,
                            _newPasswordController.text);
                      } else {
                        Utilities.showToast(
                            "New Password cannot be same as old password",
                            toastType: ToastType.error);
                      }
                    } else {
                      Utilities.showToast("All fields are required",
                          toastType: ToastType.error);
                    }
                  },
                  child: const Text(
                    "Change",
                  ),
                  // color: Constants.color,
                ),
              ],
            ),
          ),
        ),
      ),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      enableDrag: true,
    );
  }

  Widget notificationSwitch() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      elevation: 2.0,
      child: Obx(
        () => SwitchListTile.adaptive(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          inactiveThumbColor: Colors.grey,
          value: switchValue.value,
          onChanged: (value) {
            switchValue.value = value;
          },
          activeColor: Constants.color,
          title: Text("${Constants.loginType} Notification"),
        ),
      ),
    );
  }

  Widget languageSwitcher() {
    return InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        label: const Text("Language"),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Utilities.showToast("Switched to Nepali");
            },
            child: const Text("🇳🇵", style: TextStyle(fontSize: 60.0)),
          ),
          InkWell(
            onTap: () {
              Utilities.showToast("Switched to English");
            },
            child: const Text("🇬🇧", style: TextStyle(fontSize: 60.0)),
          ),
        ],
      ),
    );
  }

  Widget changePasswordTile(BuildContext context) {
    return SizedBox(
      height: Get.size.height * 0.15,
      width: Get.size.width * 0.45,
      child: InkWell(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        enableFeedback: true,
        onTap: () {
          showChangePasswordBottomSheet(context);
        },
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock,
                size: 28,
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              const Text("Change Password"),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoutTile(BuildContext context) {
    return SizedBox(
      height: Get.size.height * 0.15,
      width: Get.size.width * 0.45,
      child: InkWell(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        enableFeedback: true,
        onTap: () async {
          var confirm = await Utilities.showConfirmationDialog(
              context, "Confirmation", "Are you sure you want to logout?");
          print(confirm);
          if (confirm) {
            Utilities.logout();
          }
        },
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.logout,
                size: 28,
              ),
              SizedBox(
                height: Get.size.height * 0.01,
              ),
              const Text("Logout"),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Settings",
          style: TextStyle(color: Constants.color),
        ),
        leading: Get.find<AuthController>().users!.userType == Constants.driver
            ? null
            : Icon(
                Icons.settings,
                color: Constants.color,
              ),
        color: Constants.color,
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Constants.verticalPadding),
        child: Column(
          children: [
            notificationSwitch(),
            SizedBox(
              height: Get.size.height * 0.02,
            ),
            languageSwitcher(),
            SizedBox(
              height: Get.size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                changePasswordTile(context),
                logoutTile(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
