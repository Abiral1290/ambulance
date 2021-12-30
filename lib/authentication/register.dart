import 'package:ambulance_nepal/authentication/user.dart';
import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/utils/utilities.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:ambulance_nepal/widget/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  InputDecoration decoration(String label, Icon icon) {
    return InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.borderRadius)),
      label: Text(label),
      prefixIcon: icon,
    );
  }

  bool validateRequired() {
    return _nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty;
  }

  bool validateNumber() {
    return _phoneController.text.isPhoneNumber &&
        _phoneController.text.length == 10;
  }

  bool validateEmail() {
    return _emailController.text.isEmail;
  }

  Users assignValue() {
    Users users = Users();
    users.name = _nameController.text;
    users.email = _emailController.text;
    users.phone = _phoneController.text;
    users.userType = Constants.loginType;
    return users;
  }

  Widget _nextButton(BuildContext context) {
    return Center(
      child: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: Constants.verticalPadding),
          child: MaterialButton(
            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());

              if (validateRequired()) {
                if (validateNumber()) {
                  if (validateEmail()) {
                    Users user = assignValue();
                    print(user);
                    Get.to(() => PasswordField(user: user));
                  } else {
                    Utilities.showToast("Email is not valid",
                        toastType: ToastType.error);
                  }
                } else {
                  Utilities.showToast("Phone number is not in valid format",
                      toastType: ToastType.error);
                }
              } else {
                Utilities.showToast("All Fields are required",
                    toastType: ToastType.error);
              }
            },
            child: const Text("Next"),
            color: Constants.color,
            height: Get.size.height * 0.05,
            minWidth: Get.size.width,
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
            ),
            textColor: Colors.white,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: key,
      appBar: appBar(
        Text(
          " Register",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
      // appBar: AppBar(
      //   title: Text(Constants.loginType + " Register"),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Constants.verticalPadding),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalPadding),
                child: TextField(
                  controller: _nameController,
                  decoration: decoration("Name", const Icon(Icons.person)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalPadding),
                child: TextField(
                  controller: _emailController,
                  decoration: decoration("Email", const Icon(Icons.email)),
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: Constants.verticalPadding),
                child: TextField(
                  controller: _phoneController,
                  decoration: decoration("Phone", const Icon(Icons.phone)),
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                ),
              ),
              _nextButton(context),
            ],
          ),
        ),
      ),
    );
  }
}
