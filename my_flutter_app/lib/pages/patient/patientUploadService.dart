import 'dart:io';
import 'package:my_flutter_app/dto/PatientModelRequest.dart';
import '../../URL.dart';

class patientUploadService {
  Future<int> createPatient(
      PatientModelRequest patientData, File consentForm, String patientIdFromHeader) async {
    final responseCode = await patientUpload(
        patientData.patientId ,
        patientData.clinicianId,
        patientData.patientName,
        patientData.riskFactors ?? [],
        patientData.dob,
        patientData.gender,
        patientData.histoDiagnosis ?? "",
        patientData.medicalHistory ?? [],
        patientData.familyHistory ?? [],
        patientData.systemicDisease ?? "",
        patientData.contactNo,
        patientData.consentForm,
        consentForm,
        patientIdFromHeader
    );
    return responseCode;
  }
}