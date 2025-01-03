import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/my_button_2.dart';
import 'package:my_flutter_app/controller/DataProvider.dart';
import 'package:my_flutter_app/modals/PatientDetails.dart';
import 'package:my_flutter_app/pages/viewers/pdfViewerPage.dart';
import '../TeleconEntry/AddTeleconEntryScreen.dart';
import '../TeleconEntry/shareTeleconEntries.dart';

class PatientProfile extends StatefulWidget {
  final void Function()? onTap;
  final String patientId;
  final String consentFormPath = URL.BASE_URL + "/Storage/ConsentForms";
  const PatientProfile({
    super.key,
    required this.onTap,
    required this.patientId,
  });

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final TextEditingController patientNameController = TextEditingController();
  String selectedItem = 'Access I';
  PatientDetails? patientDetails;

  @override
  void initState() {
    super.initState();
    DataProvider dataProvider = DataProvider();

    dataProvider.getPatientById(widget.patientId).then((patient) {
      if (patient != null) {
        setState(() {
          patientDetails = patient;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate back to the previous screen by popping the current route
            Navigator.pushNamed(context, '/pageNav');
          },
        ),
        title: const Text(
          "Patient's Profile",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 152, 195, 235),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 152, 195, 235),
                Color.fromARGB(255, 224, 235, 250),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 236, 236, 236),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            '• Patient ID:',
                            style: TextStyle(
                              fontSize: 23,
                              fontFamily: "Rubik",
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 10.0,
                                  color: Color.fromARGB(128, 114, 118, 121),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              patientDetails?.getPatientId ?? '',
                              style: const TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Rubik',
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '• Patient Name:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                  shadows: [
                                    Shadow(
                                      offset: Offset(1.0, 1.0),
                                      blurRadius: 10.0,
                                      color: Color.fromARGB(128, 114, 118, 121),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 5),
                              Center(
                                child: Text(
                                  '     ${patientDetails?.getPatientName ?? ''}',
                                  style: const TextStyle(
                                    fontSize: 23,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Rubik',
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                child: const Text(
                  'Status',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 46, 74, 95),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 236, 236, 236),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 420,
                    width: 390,
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      width: 20,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    '• DOB:',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "Rubik",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      patientDetails?.getDob ?? '',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    '• Age:',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "Rubik",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      patientDetails?.getAge().toString() ?? '',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    '• Gender:',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "Rubik",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      patientDetails?.getGender ?? '',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: Row(
                                children: [
                                  const Text(
                                    '• Contact Number:',
                                    style: TextStyle(
                                      fontSize: 23,
                                      fontFamily: "Rubik",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      patientDetails?.getContactNo ?? '',
                                      style: const TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w400,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• Previous history of cancer:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getMedicalHistory
                                        ?.map((item) => Text(
                                              '    • $item',
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• History Diagnosis:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getHistoDiagnosis !=
                                          null
                                      ? '       • ${patientDetails!.getHistoDiagnosis}'
                                      : '',
                                ),
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• Family history of cancer:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getFamilyHistory
                                        ?.map((item) => Text(
                                              '       • $item',
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• Systemic disease:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getSystemicDisease !=
                                          null
                                      ? '       • ${patientDetails!.getSystemicDisease}'
                                      : '',
                                ),
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• Risk Habits:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getRiskFactors
                                        ?.map((item) => Text(
                                              '       • Habit: ${item.habit},\n       • Frequency: ${item.frequency},\n       • Duration: ${item.duration}',
                                              style: const TextStyle(
                                                fontSize: 23,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ))
                                        .toList() ??
                                    [],
                              ),
                            ),
                            ListTile(
                              title: const Text(
                                '• Created At:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getCreatedAt ?? '',
                                ),
                                // onChanged: (value) {
                                //   new_name = value;
                                // },
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            const ListTile(
                              title: Text(
                                'Consent Form:',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontFamily: "Rubik",
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PdfViewerPage(
                                        filename:
                                            patientDetails?.getPatientId ?? ''),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color.fromARGB(255, 200, 235,
                                    255), // Add your desired color here
                              ),
                              child: const Text(
                                'REPORT',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 54, 54,
                                      54), // Add your desired text color here
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(70.w, 20.h, 20.w, 0.h),
                    child: Container(
                      width: 120.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[400], // Blue background
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShareEntriesScreen(
                                patientId: patientDetails!.getId!,
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          'Share Entry',
                          style: TextStyle(
                            color: Colors.white, // White text color
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                        20, 20, 22, 0), // Adjust padding to match
                    child: Container(
                      width: 120.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.blue[400], // Blue background
                        borderRadius:
                            BorderRadius.circular(10), // Rounded corners
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TeleconEntryForm(
                                patientId: patientDetails!.getId!,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          "New Entry",
                          style: TextStyle(
                            color: Colors.white, // White text color
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 40, 0),
                  child: const Text(
                    '@mobile version of OASIS',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 52, 54, 57),
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
