import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Widget buildReportCard() {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: Color.fromARGB(255, 219, 242, 255),
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset('lib/images/image.jpg',
                  height: 100, width: double.infinity, fit: BoxFit.cover),
            ),
            SizedBox(height: 8),
            Text(
              'Name: Sahan Dissanayake',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Rubik'),
            ),
            Text('Age: 34', style: TextStyle(fontFamily: 'Rubik')),
            Text('ID: ABCD', style: TextStyle(fontFamily: 'Rubik')),
            Text('District: Kandy', style: TextStyle(fontFamily: 'Rubik')),
            Text('Date: 12/12/2022', style: TextStyle(fontFamily: 'Rubik')),
          ],
        ),
      ));
}
