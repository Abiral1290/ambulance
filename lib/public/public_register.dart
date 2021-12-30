import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';

class PublicRegisterPage extends StatelessWidget {
  const PublicRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Register Public",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
    );
  }
}
