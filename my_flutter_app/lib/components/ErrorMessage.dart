import 'package:flutter/material.dart';
import 'package:get/get.dart';

void ErrorMessage(String error) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "Error",
    error,
    icon: Icon(Icons.error, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Color.fromARGB(255, 197, 25, 13),
    colorText: Colors.white,
    margin: EdgeInsets.all(10),
    borderRadius: 8,
    duration: Duration(seconds: 3),
  );
}
