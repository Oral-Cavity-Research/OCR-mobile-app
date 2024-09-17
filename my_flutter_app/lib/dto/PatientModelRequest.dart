import 'RiskFactors.dart';

class PatientModelRequest {
  final String patientId;
  final String clinicianId;
  final String patientName;
  final List<RiskFactors>? riskFactors;
  final String dob;
  final String gender;
  final String histoDiagnosis;
  final List<String> medicalHistory;
  final List<String> familyHistory;
  final String systemicDisease;
  final String contactNo;
  final String consentForm;

  PatientModelRequest({
    required this.patientId,
    required this.clinicianId,
    required this.patientName,
    this.riskFactors,
    required this.dob,
    required this.gender,
    required this.histoDiagnosis,
    required this.medicalHistory,
    required this.familyHistory,
    required this.systemicDisease,
    required this.contactNo,
    required this.consentForm,
  });

  Map<String, dynamic> toJson() {
    return {
      'patient_id': patientId,
      'clinician_id': clinicianId,
      'patient_name': patientName,
      'risk_factors': riskFactors?.map((e) => e.toJson()).toList(),
      'DOB': dob,
      'gender': gender,
      'histo_diagnosis': histoDiagnosis,
      'medical_history': medicalHistory,
      'family_history': familyHistory,
      'systemic_disease': systemicDisease,
      'contact_no': contactNo,
      'consent_form': consentForm,
    };
  }

  factory PatientModelRequest.fromJson(Map<String, dynamic> json) {
    return PatientModelRequest(
      patientId: json['patient_id'],
      clinicianId: json['clinician_id'],
      patientName: json['patient_name'],
      riskFactors: (json['risk_factors'] as List)
          .map((e) => RiskFactors.fromJson(e))
          .toList(),
      dob: json['DOB'],
      gender: json['gender'],
      histoDiagnosis: json['histo_diagnosis'],
      medicalHistory: List<String>.from(json['medical_history'] ?? []),
      familyHistory: List<String>.from(json['family_history'] ?? []),
      systemicDisease: json['systemic_disease'],
      contactNo: json['contact_no'],
      consentForm: json['consent_form'],
    );
  }
}