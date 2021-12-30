import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget appBar(Widget title,
    {Widget? leading, Color? color, List<Widget>? actions}) {
  return AppBar(
    title: title,
    elevation: 0.0,
    backgroundColor: Colors.transparent,
    leading: leading ??
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: color ?? Colors.black,
          ),
        ),
    actions: actions ?? [],
  );
}
