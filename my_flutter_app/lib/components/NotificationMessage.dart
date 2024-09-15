import 'package:flutter/material.dart';
import 'package:get/get.dart';

void NotificationMessage(String Notification, String title) {
  Get.closeAllSnackbars();
  Get.snackbar(
    title,
    Notification,
    icon: const Icon(Icons.account_circle_sharp,
        color: Color.fromARGB(255, 13, 1, 68)),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: Color.fromARGB(255, 121, 155, 235),
    colorText: Color.fromARGB(255, 11, 3, 45),
    margin: const EdgeInsets.all(10),
    borderRadius: 8,
    duration: const Duration(seconds: 3),
  );
}
