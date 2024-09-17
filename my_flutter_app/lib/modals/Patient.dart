import 'package:flutter/material.dart';

class Patient with ChangeNotifier {
  final String id;
  final String patientId;
  final String patientName;
  final String dob;
  final String gender;

  Patient({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.dob,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      dob: json['dob'],
      gender: json['gender'],
    );
  }

  String get getId => id;
  String get getPatientId => patientId;
  String get getPatientName => patientName;
  String get getDob => dob;
  String get getGender => gender;

  void updatePatients(List<Patient>? patients) {}
}
