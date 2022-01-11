import 'package:ambulance_nepal/authentication/auth_controller.dart';
import 'package:ambulance_nepal/authentication/register.dart';
import 'package:ambulance_nepal/driver/driver_register.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  var obscureText = true.obs;

  int role = 7;

  decoration(String label, Icon prefixIcon) {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        label: Text(label),
        prefixIcon: prefixIcon,
        suffixIcon: label == "Password"
            ? Obx(() => IconButton(
                onPressed: () {
                  obscureText.value = !obscureText.value;
                },
                icon: obscureText.value
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)))
            : null);
  }

  handleRegisterButton() {
    switch (Constants.loginType) {
      case Constants.public:
        Get.to(() => RegisterPage());
        break;
      case Constants.driver:
        Get.to(() => DriverRegisterPage());
        break;
      case Constants.admin:
        Get.to(() => RegisterPage());
        break;
      case Constants.traffic:
        Get.to(() => RegisterPage());
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          Constants.loginType + " login",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                    "assets/images/ams_transparent.png",
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.verticalPadding),
                  child: TextField(
                    controller: _phoneController,
                    decoration: decoration("Phone", const Icon(Icons.phone)),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.verticalPadding),
                  child: Obx(() => TextField(
                        controller: _passwordController,
                        decoration:
                            decoration("Password", const Icon(Icons.lock)),
                        obscureText: obscureText.value,
                      )),
                ),
                GetBuilder<AuthController>(builder: (builder) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Constants.verticalPadding),
                    child: MaterialButton(
                      onPressed: Get.find<AuthController>().fcmToken.isNotEmpty
                          ? () {
                              FocusScope.of(context).requestFocus(FocusNode());

                              Utilities.showAlertDialog(
                                  context, "Please Wait", "Logging In");
                              if (_phoneController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty) {
                                switch (Constants.loginType) {
                                  case Constants.driver:
                                    role = 7;
                                    break;
                                  case Constants.traffic:
                                    role = 8;
                                    break;
                                  case Constants.admin:
                                    role = 9;
                                    break;
                                  case Constants.public:
                                    role = 10;
                                    break;
                                  default:
                                    role = 10;
                                    break;
                                }
                                Get.find<AuthController>().loginUser(
                                    _phoneController.text,
                                    _passwordController.text,
                                    role.toString(),
                                    Get.find<AuthController>().fcmToken);
                              } else {
                                Utilities.showToast("All Field are required",
                                    toastType: ToastType.error);
                                Get.back();
                              }
                            }
                          : null,
                      child: const Text("Login"),
                      color: Constants.color,
                      height: Get.size.height * 0.05,
                      minWidth: Get.size.width,
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Constants.borderRadius),
                      ),
                      textColor: Colors.white,
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: Constants.verticalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      InkWell(
                        child: Text(
                          "Register Here",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            color: Constants.color,
                          ),
                        ),
                        onTap: handleRegisterButton,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
