import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget buildMenuButton(icon, String title, Function function) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26, // Shadow color
            blurRadius: 10, // Blur radius
            offset: Offset(0, 5), // Shadow offset
          ),
        ],
      ),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation:
              0, // Set elevation to 0 to avoid conflict with BoxDecoration shadow
        ),
        icon: Icon(icon, color: Colors.blue),
        label: Text(title, style: TextStyle(color: Colors.blue)),
        onPressed: () {
          function();
        },
      ),
    ),
  );
}
