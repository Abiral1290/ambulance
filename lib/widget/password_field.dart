import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/driver/driver_controller.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PasswordField extends StatelessWidget {
  PasswordField({Key? key, required this.user}) : super(key: key);

  dynamic user;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  var obscureText = [true, true].obs;

  InputDecoration decoration(String label, int index) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      label: Text(label),
      prefixIcon: const Icon(Icons.lock),
      suffixIcon: IconButton(
        onPressed: () {
          obscureText[index] = !obscureText[index];
        },
        icon: obscureText[index]
            ? const Icon(
                Icons.visibility_off,
                color: Colors.grey,
                size: 20.0,
              )
            : const Icon(
                Icons.visibility,
                color: Colors.blue,
                size: 20.0,
              ),
      ),
    );
  }

  bool validateEmptyFields() {
    return _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  bool validatePasswords() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  registerOtherUser() async {
    var data = await Get.find<AuthController>().registerUser(user);
    Get.back();
    if (data) {
      Get.close(2); // go back 2 step
    }
  }

  registerDriver() async {
    var data = await Get.find<DriverController>().registerDriver(user);
    Get.back();
    if (data) {
      Get.close(2); // go back 2 step
    }
  }

  _handleSubmit() {
    user.password = _passwordController.text;
    switch (user.userType) {
      case Constants.public:
        registerOtherUser();
        break;

      case Constants.driver:
        registerDriver();
        break;

      case Constants.traffic:
        registerOtherUser();
        break;

      case Constants.admin:
        registerOtherUser();
        break;

      default:
    }
    print(user);
  }

  Widget _submitButton(BuildContext context) {
    return Center(
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
        child: MaterialButton(
          onPressed: () {
            FocusScope.of(context).requestFocus(FocusNode());

            Utilities.showAlertDialog(context, "Please wait", "");
            if (validateEmptyFields()) {
              if (validatePasswords()) {
                _handleSubmit();
              } else {
                Get.back();
                Utilities.showToast("Passwords do not match");
              }
            } else {
              Get.back();
              Utilities.showToast("All Fields are required");
            }
          },
          child: const Text("Register"),
          color: Constants.color,
          height: Get.size.height * 0.05,
          minWidth: Get.size.width,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
          ),
          textColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Add Password",
          style: TextStyle(color: Constants.color),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalPadding),
                child: Obx(
                  () => TextField(
                    controller: _passwordController,
                    decoration: decoration("Password", 0),
                    obscureText: obscureText[0],
                    obscuringCharacter: ".",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalPadding),
                child: Obx(
                  () => TextField(
                    controller: _confirmPasswordController,
                    decoration: decoration("Confirm Password", 1),
                    obscureText: obscureText[1],
                    obscuringCharacter: ".",
                  ),
                ),
              ),
              _submitButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
