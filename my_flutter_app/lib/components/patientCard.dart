import 'package:flutter/material.dart';

Widget patientCard({
  required String name,
  required String id,
  required String dob,
  required String gender,
}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    elevation: 4,
    color: const Color.fromARGB(255, 219, 242, 255),
    shadowColor: Colors.black26,
    child: Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
          ),
          Text(
            'Name: $name',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Rubik',
            ),
          ),
          Text(
            'ID: $id',
            style: const TextStyle(fontFamily: 'Rubik'),
          ),
          Text(
            'Date of birth: $dob',
            style: const TextStyle(fontFamily: 'Rubik'),
          ),
          Text(
            'Gender: $gender',
            style: const TextStyle(fontFamily: 'Rubik'),
          ),
        ],
      ),
    ),
  );
}
