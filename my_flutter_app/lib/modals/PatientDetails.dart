import 'package:my_flutter_app/modals/subModals/RiskFactors.dart';

class PatientDetails {
  String? systemicDisease;
  String? id;
  String? patientId;
  String? clinicianId;
  String? patientName;
  List<RiskFactor>? riskFactors;
  String? gender;
  String? histoDiagnosis;
  List<String>? medicalHistory;
  List<String>? familyHistory;
  String? contactNo;
  String? consentForm;
  String? createdAt;
  String? updatedAt;
  String? dob;
  PatientDetails({
    this.systemicDisease,
    this.id,
    this.patientId,
    this.clinicianId,
    this.patientName,
    this.riskFactors,
    this.gender,
    this.histoDiagnosis,
    this.medicalHistory,
    this.familyHistory,
    this.contactNo,
    this.consentForm,
    this.createdAt,
    this.updatedAt,
    this.dob,
  });

  // Factory method to create an instance from JSON
  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    print('json: $json');

    String getString(dynamic value) {
      if (value is String) {
        print("////////////////////\\\\\\\\\\");
        return value;
      } else {
        print('Expected String but got ${value.runtimeType}');
        return '';
      }
    }

    List<String> getStringList(dynamic value) {
      if (value is List) {
        print("????????????????????????");
        return List<String>.from(value);
      } else {
        print('Expected List but got ${value.runtimeType}');
        return [];
      }
    }

    DateTime getDateTime(dynamic value) {
      if (value is String) {
        print("jjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj");
        return DateTime.parse(value);
      } else {
        print('Expected String for DateTime but got ${value.runtimeType}');
        return DateTime.now();
      }
    }

    List<RiskFactor> getRiskFactorList(dynamic value) {
      if (value is List) {
        return value.map((e) => RiskFactor.fromJson(e)).toList();
      } else {
        print('Expected List but got ${value.runtimeType}');
        return [];
      }
    }

    return PatientDetails(
      systemicDisease: getString(json['systemic_disease']),
      id: getString(json['_id']),
      patientId: getString(json['patient_id']),
      clinicianId: getString(json['clinician_id']),
      dob: getString(json['dob']),
      patientName: getString(json['patient_name']),
      riskFactors: getRiskFactorList(json['risk_factors']),
      gender: getString(json['gender']),
      histoDiagnosis: getString(json['histo_diagnosis']),
      medicalHistory: getStringList(json['medical_history']),
      familyHistory: getStringList(json['family_history']),
      contactNo: getString(json['contact_no']),
      consentForm: getString(json['consent_form']),
      createdAt: getString(json['createdAt']),
      updatedAt: getString(json['updatedAt']),
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'systemic_disease': systemicDisease,
      '_id': id,
      'patient_id': patientId,
      'clinician_id': clinicianId,
      'dob': dob,
      'patient_name': patientName,
      'risk_factors': riskFactors,
      'gender': gender,
      'histo_diagnosis': histoDiagnosis,
      'medical_history': medicalHistory,
      'family_history': familyHistory,
      'contact_no': contactNo,
      'consent_form': consentForm,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Getters and setters
  String? get getSystemicDisease => systemicDisease;
  set setSystemicDisease(String? value) => systemicDisease = value;

  String? get getId => id;
  set setId(String? value) => id = value;

  String? get getPatientId => patientId;
  set setPatientId(String? value) => patientId = value;

  String? get getClinicianId => clinicianId;
  set setClinicianId(String? value) => clinicianId = value;

  String? get getDob => dob;
  set setDob(String? value) => dob = value;
  String? get getPatientName => patientName;
  set setPatientName(String? value) => patientName = value;

  List<RiskFactor>? get getRiskFactors => riskFactors;
  set setRiskFactors(List<RiskFactor>? value) => riskFactors = value;

  String? get getGender => gender;
  set setGender(String? value) => gender = value;

  String? get getHistoDiagnosis => histoDiagnosis;
  set setHistoDiagnosis(String? value) => histoDiagnosis = value;

  List<String>? get getMedicalHistory => medicalHistory;
  set setMedicalHistory(List<String>? value) => medicalHistory = value;

  List<String>? get getFamilyHistory => familyHistory;
  set setFamilyHistory(List<String>? value) => familyHistory = value;

  String? get getContactNo => contactNo;
  set setContactNo(String? value) => contactNo = value;

  String? get getConsentForm => consentForm;
  set setConsentForm(String? value) => consentForm = value;

  String? get getCreatedAt => createdAt;
  set setCreatedAt(String? value) => createdAt = value;

  String? get getUpdatedAt => updatedAt;
  set setUpdatedAt(String? value) => updatedAt = value;

  int? getAge() {
    if (dob != null) {
      DateTime now = DateTime.now();
      DateTime dateOfBirth = DateTime.parse(dob!);
      int age = now.year - dateOfBirth.year;
      if (now.month < dateOfBirth.month ||
          (now.month == dateOfBirth.month && now.day < dateOfBirth.day)) {
        age--;
      }
      return age;
    }
    return null;
  }
}
