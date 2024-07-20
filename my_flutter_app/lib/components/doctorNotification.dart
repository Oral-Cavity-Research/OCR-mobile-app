import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget buildDoctorNotification(String id, String patient_id, String date) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Color.fromARGB(255, 219, 242, 255),
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('lib/images/sampleDoc.jpg',
                  height: 100, width: 100, fit: BoxFit.cover),
            ),
            SizedBox(height: 8),
            Padding(padding: EdgeInsets.all(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('$id',
                    style: TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text('$patient_id', style: TextStyle(fontFamily: 'Rubik')),
                Text('$date', style: TextStyle(fontFamily: 'Rubik')),
              ],
            ),
          ],
        ),
      ));
}
