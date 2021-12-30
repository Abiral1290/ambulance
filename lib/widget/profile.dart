import 'package:ambulance_nepal/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key, required this.user}) : super(key: key);

  final dynamic user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.verticalPadding),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.borderRadius),
          color: Colors.grey[600],
        ),
        width: Get.size.width,
        child: Card(
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius),
              borderSide: BorderSide.none),
          child: Padding(
            padding: const EdgeInsets.all(Constants.verticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  user.email,
                  style: const TextStyle(
                    fontSize: 19.0,
                  ),
                ),
                Text(
                  user.phone,
                  style: const TextStyle(
                    fontSize: 19.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text("Joined Date: "),
                    Text(DateFormat.yMMMEd()
                        .format(DateTime.parse(user.createdAt))),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
