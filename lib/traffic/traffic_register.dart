import 'package:ambulance_nepal/utils/constants.dart';
import 'package:ambulance_nepal/widget/appbar.dart';
import 'package:flutter/material.dart';

class TrafficRegisterPage extends StatelessWidget {
  const TrafficRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        Text(
          "Register Traffic",
          style: TextStyle(color: Constants.color),
        ),
        color: Constants.color,
      ),
    );
  }
}
