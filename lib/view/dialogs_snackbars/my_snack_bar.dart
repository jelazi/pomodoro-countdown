import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static warningSnackBar(String title, String message) {
    Get.snackbar(
      title,
      message,
      icon: const Icon(
        Icons.warning,
        color: Colors.red,
      ),
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.black,
      borderWidth: 2,
      borderColor: Colors.white,
    );
  }
}
