import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/dto/PatientModelRequest.dart';
import 'package:my_flutter_app/pages/patient/patientUploadService.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../components/ResponsePopup.dart';
import '../../dto/RiskFactors.dart';

class PatientConsentForm extends StatefulWidget {
  @override
  _PatientConsentFormState createState() => _PatientConsentFormState();
}

class _PatientConsentFormState extends State<PatientConsentForm> {
  final _formKey = GlobalKey<FormState>();
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  // Form field controllers
  final TextEditingController patientIdController = TextEditingController();
  final TextEditingController clinicianIdController = TextEditingController();
  final TextEditingController patientNameController = TextEditingController();
  final List<TextEditingController> riskFactorsController = List.generate(1, (index) => TextEditingController());
  final TextEditingController dobController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController histoDiagnosisController = TextEditingController();
  final TextEditingController medicalHistoryController = TextEditingController();
  final TextEditingController familyHistoryController = TextEditingController();
  final TextEditingController systemicDiseaseController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController consentFormController = TextEditingController();



  @override
  void dispose() {
    _signatureController.dispose();
    super.dispose();
  }

  // Request storage permission
  Future<bool> _requestPermission() async {
    final status = await Permission.storage.request();
    return status.isGranted;
  }

  // Method to generate consent form
  Future<void> _generatePdf(Uint8List? signature) async {

      final pdf = pw.Document();

      pdf.addPage(
          pw.Page(
            build: (pw.Context context) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Patient Data Collection Consent Form", style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 20),
                pw.RichText(
                  text: pw.TextSpan(
                    text: "I, ",
                    style: pw.TextStyle(fontSize: 14),
                    children: [
                      pw.TextSpan(text: patientNameController.text, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, color: PdfColors.blue900)),
                      pw.TextSpan(text: " [${patientIdController.text}], hereby consent to the collection of my personal health information by OCR Tool for the purpose of data collection and analysis."),
                    ],
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Text("The personal health information that will be collected includes:", style: pw.TextStyle(fontSize: 14)),
                pw.Bullet(text: "Demographic information such as name, date of birth, address, phone number, and email address", style: pw.TextStyle(fontSize: 12)),
                pw.Bullet(text: "Medical history and diagnosis information", style: pw.TextStyle(fontSize: 12)),
                pw.Bullet(text: "Treatment and medication information", style: pw.TextStyle(fontSize: 12)),
                pw.Bullet(text: "Laboratory and diagnostic test results", style: pw.TextStyle(fontSize: 12)),
                pw.Bullet(text: "Intraoral and Extraoral photographs", style: pw.TextStyle(fontSize: 12)),
                pw.SizedBox(height: 20),
                pw.Text(
                  "I understand that this information will be used for research purposes and may be shared with other healthcare providers or researchers for improving patient care. I understand my personal information will be kept confidential and will not be disclosed to any unauthorized individuals or organizations.",
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 20),
                pw.Text(
                  "I hereby give my consent for the collection and use of my personal health information and oral images for data collection and analysis purposes.",
                  style: pw.TextStyle(fontSize: 14),
                ),
                pw.SizedBox(height: 40),
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Signature:", style: pw.TextStyle(fontSize: 16)),
                        signature != null
                            ? pw.Image(pw.MemoryImage(signature), width: 150, height: 80)
                            : pw.Text("No signature provided.", style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Signature: ${patientNameController.text}", style: pw.TextStyle(fontSize: 12)),
                        pw.Text("Date: ${DateFormat('dd/MM/yyyy').format(DateTime.now())}", style: pw.TextStyle(fontSize: 12)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
      );

      final directory = await getApplicationDocumentsDirectory();
      final filePath = "${directory.path}/patient_consent_form.pdf";
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      // Call patientUpload after creating the file
      await _submitForm(context, file ) ;

  }

  Future<void> _submitForm(BuildContext context, File file) async {
    if (_formKey.currentState!.validate() && file != null) {
      List<RiskFactors> ParseRiskFactors(List<TextEditingController> controllers) {
        return controllers
            .where((controller) => controller.text.isNotEmpty) // Filter out empty fields
            .map((controller) {
          final jsonMap = jsonDecode(controller.text); // Decode text to Map
          return RiskFactors.fromJson(jsonMap); // Convert to RiskFactors object
        }).toList();
      }
      PatientModelRequest patientData = PatientModelRequest(
        patientId: patientIdController.text,
        clinicianId: clinicianIdController.text,
        patientName: patientNameController.text,
        riskFactors: riskFactorsController.isNotEmpty? ParseRiskFactors(riskFactorsController):null,
        dob: dobController.text,
        gender: genderController.text,
        histoDiagnosis: histoDiagnosisController.text,
        medicalHistory: medicalHistoryController.text.split(',').map((e) => e.trim()).toList(), // Assuming comma-separated values
        familyHistory: familyHistoryController.text.split(',').map((e) => e.trim()).toList(), // Assuming comma-separated values
        systemicDisease: systemicDiseaseController.text,
        contactNo: contactNoController.text,
        consentForm: consentFormController.text,
      );

      if (file.existsSync()) {
        print("File exists at path: ${file?.path}");
      } else {
        print("File does not exist!");
      }

      final responseCode = await patientUploadService().createPatient(patientData, file,patientData.patientId);

      if (responseCode == 200) {
        print('ConsentForm uploaded successfully');
        await responsePopup(context, "Success", "ConsentForm uploaded successfully!");
      } else {
        print('ConsentForm upload failed. Status code: $responseCode');
        responsePopup(context, "Failure", "Error uploading file: $responseCode");
      }
    } else {
      print('Form validation failed or image not selected');
      responsePopup(context, "Failure", "Form validation failed or image not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(title: Text("Patient Consent Form",style: TextStyle(
        fontFamily: 'Rubik',
        color: Colors.white,
      ),
      ),
        backgroundColor: Colors.blue[900],),
    body: Container(
    decoration: const BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
    Color.fromARGB(255, 101, 174, 244),
    Color.fromARGB(255, 148, 192, 233),
    Color.fromARGB(255, 206, 219, 239),
    ],
    ),
    ),
    child: Padding(
    padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Patient ID
              TextFormField(
                controller: patientIdController,
                decoration: InputDecoration(labelText: "Patient ID"),
                validator: (value) => value!.isEmpty ? "Patient ID is required" : null,
              ),
              // Clinician ID
              TextFormField(
                controller: clinicianIdController,
                decoration: InputDecoration(labelText: "Clinician ID"),
                validator: (value) => value!.isEmpty ? "Clinician ID is required" : null,
              ),
              // Patient Name
              TextFormField(
                controller: patientNameController,
                decoration: InputDecoration(labelText: "Patient Name"),
                validator: (value) => value!.isEmpty ? "Patient Name is required" : null,
              ),
              // Risk Factors (Optional)
              Column(
                children: List.generate(riskFactorsController.length, (index) {
                  return TextFormField(
                    controller: riskFactorsController[index],
                    decoration: InputDecoration(labelText: "Risk Factor ${index + 1}"),
                  );
                }),
              ),
              // Date of Birth (DOB)
              TextFormField(
                controller: dobController,
                decoration: InputDecoration(labelText: "Date of Birth"),
                validator: (value) => value!.isEmpty ? "Date of Birth is required" : null,
              ),
              // Gender
              TextFormField(
                controller: genderController,
                decoration: InputDecoration(labelText: "Gender"),
                validator: (value) => value!.isEmpty ? "Gender is required" : null,
              ),
              // Histological Diagnosis
              TextFormField(
                controller: histoDiagnosisController,
                decoration: InputDecoration(labelText: "Histological Diagnosis"),
                validator: (value) => value!.isEmpty ? "Histological Diagnosis is required" : null,
              ),
              // Medical History (comma-separated)
              TextFormField(
                controller: medicalHistoryController,
                decoration: InputDecoration(labelText: "Medical History (comma-separated)"),
                validator: (value) => value!.isEmpty ? "Medical History is required" : null,
              ),
              // Family History (comma-separated)
              TextFormField(
                controller: familyHistoryController,
                decoration: InputDecoration(labelText: "Family History (comma-separated)"),
                validator: (value) => value!.isEmpty ? "Family History is required" : null,
              ),
              // Systemic Disease
              TextFormField(
                controller: systemicDiseaseController,
                decoration: InputDecoration(labelText: "Systemic Disease"),
                validator: (value) => value!.isEmpty ? "Systemic Disease is required" : null,
              ),
              // Contact Number
              TextFormField(
                controller: contactNoController,
                decoration: InputDecoration(labelText: "Contact Number"),
                keyboardType: TextInputType.phone,
                validator: (value) => value!.isEmpty ? "Contact Number is required" : null,
              ),
              // Consent Form (Optional)
              TextFormField(
                controller: consentFormController,
                decoration: InputDecoration(labelText: "Consent Form"),
                validator: (value) => value!.isEmpty ? "Consent Form is required" : null,
              ),
              const SizedBox(height: 20),
              // Signature Area
              Text("Signature:", style: TextStyle(fontSize: 18)),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Signature(controller: _signatureController, backgroundColor: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _signatureController.clear();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Navy blue color
                    ),
                    child: Text("Clear Signature", style: TextStyle(color: Colors.white)),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final signature = await _signatureController.toPngBytes();
                        await _generatePdf(signature);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900], // Navy blue color
                    ),
                    child: Text("Generate PDF", style: TextStyle(color: Colors.white)),
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
