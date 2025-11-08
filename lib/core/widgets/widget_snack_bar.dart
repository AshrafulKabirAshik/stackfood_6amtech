import '/core/values/app_values.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetSnackBar {
  static void show({
    required String title,
    required String message,
    Color backgroundColor = Colors.black,
    Color textColor = Colors.white,
    SnackPosition position = SnackPosition.BOTTOM,
    Duration duration = const Duration(seconds: 2),
    IconData? icon,
  }) {


    // close any existing/pending snackbars
    Get.closeAllSnackbars();

    Get.snackbar(
      title,
      message,
      backgroundColor: backgroundColor,
      colorText: textColor,
      snackPosition: position,
      duration: duration,
      icon: icon != null ? Icon(icon, color: textColor) : null,
      margin: const EdgeInsets.all(AppValues.contentPadding),
      borderRadius: AppValues.childCornerRadius,
    );
  }
}
