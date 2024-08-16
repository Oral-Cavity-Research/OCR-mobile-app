
import 'package:flutter/material.dart';

Widget buildReportCard() {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: const Color.fromARGB(255, 219, 242, 255),
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
            const SizedBox(height: 8),
            const Text(
              'Name: Sahan Dissanayake',
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Rubik'),
            ),
            const Text('Age: 34', style: TextStyle(fontFamily: 'Rubik')),
            const Text('ID: ABCD', style: TextStyle(fontFamily: 'Rubik')),
            const Text('District: Kandy', style: TextStyle(fontFamily: 'Rubik')),
            const Text('Date: 12/12/2022', style: TextStyle(fontFamily: 'Rubik')),
          ],
        ),
      ));
}
