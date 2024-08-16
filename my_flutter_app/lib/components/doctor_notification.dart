
import 'package:flutter/material.dart';

Widget buildDoctorNotification(String id, String patientId, String date) {
  return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      color: const Color.fromARGB(255, 219, 242, 255),
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
            const SizedBox(height: 8),
            const Padding(padding: EdgeInsets.all(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(id,
                    style: const TextStyle(
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                Text(patientId, style: const TextStyle(fontFamily: 'Rubik')),
                Text(date, style: const TextStyle(fontFamily: 'Rubik')),
              ],
            ),
          ],
        ),
      ));
}
