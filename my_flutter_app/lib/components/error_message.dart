import 'package:flutter/material.dart';
import 'package:get/get.dart';

void errorMessage(String error) {
  Get.closeAllSnackbars();
  Get.snackbar(
    "Error",
    error,
    icon: const Icon(Icons.error, color: Colors.white),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: const Color.fromARGB(255, 197, 25, 13),
    colorText: Colors.white,
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}
