import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';

class AdminRegisterPage extends StatelessWidget {
  const AdminRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Register Admin",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
    );
  }
}
