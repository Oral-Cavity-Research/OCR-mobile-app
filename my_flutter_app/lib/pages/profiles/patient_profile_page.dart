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
  final String consentFormPath = URL.BASE_URL_STORE + "/Storage/ConsentForms";
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
        title: Text(
          "Patient's Profile",
          style: const TextStyle(
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
              Row(
                children: [
                  // Expanded(
                  //     // child: Column(
                  //     //     // children: [
                  //     //     //   // Container(
                  //     //     //   //   padding: const EdgeInsets.only(top: 50),
                  //     //     //   //   child: const Image(
                  //     //     //   //     image: AssetImage('lib/images/icon1.png'),
                  //     //     //   //     width: 150,
                  //     //     //   //     height: 150,
                  //     //     //   //   ),
                  //     //     //   // ),
                  //     //     //   // Padding(
                  //     //     //   //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //     //     //   //   child: MyButton2(
                  //     //     //   //     onTap: () {
                  //     //     //   //       // Handle button tap
                  //     //     //   //       print('See Photos button tapped!');
                  //     //     //   //     },
                  //     //     //   //     text: 'See Photos',
                  //     //     //   //     backgroundColor: const Color.fromARGB(
                  //     //     //   //         255, 55, 123, 206), // Solid color
                  //     //     //   //     width: 120.0, // Custom width
                  //     //     //   //     height: 60.0, // Custom height
                  //     //     //   //   ),
                  //     //     //   // ),
                  //     //     //   // Padding(
                  //     //     //   //   padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  //     //     //   //   child: MyButton2(
                  //     //     //   //     onTap: () {
                  //     //     //   //       // Handle button tap
                  //     //     //   //       print('Edit Photos button tapped!');
                  //     //     //   //     },
                  //     //     //   //     text: 'Edit Photos',
                  //     //     //   //     backgroundColor: const Color.fromARGB(
                  //     //     //   //         255, 255, 88, 88), // Solid color
                  //     //     //   //     width: 120.0, // Custom width
                  //     //     //   //     height: 60.0, // Custom height
                  //     //     //   //   ),
                  //     //     //   // ),
                  //     //     // ],
                  //     //     ),
                  //     ),
                  Padding(
                    padding: EdgeInsets.only(top: 1.h, right: 20.w, left: 20.w),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 128, 175, 219),
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
                        height: 280.h,
                        width: 380.w,
                        child: Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Patient ID:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Rubik",
                                  ),
                                ),
                                subtitle: TextField(
                                  controller: TextEditingController(
                                    text: patientDetails?.getPatientId ?? '',
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
                              const SizedBox(height: 10),
                              ListTile(
                                title: const Text(
                                  'Patient Name:',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: "Rubik",
                                  ),
                                ),
                                subtitle: TextField(
                                  controller: TextEditingController(
                                    text: patientDetails?.getPatientName ?? '',
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
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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
                      color: const Color.fromARGB(255, 159, 196, 230),
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
                              title: const Text(
                                'DOB:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getDob ?? '',
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
                            ListTile(
                              title: const Text(
                                'Age:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getAge().toString(),
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
                            ListTile(
                              title: const Text(
                                'Gender:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getGender ?? '',
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
                            ListTile(
                              title: const Text(
                                'Contact Number:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getContactNo ?? '',
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
                            ListTile(
                              title: const Text(
                                'Previous history of cancer:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getMedicalHistory
                                        ?.map((item) => Text(
                                              '• $item',
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
                                'History Diagnosis:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text: patientDetails?.getHistoDiagnosis ?? '',
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
                            ListTile(
                              title: const Text(
                                'Family history of cancer:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getFamilyHistory
                                        ?.map((item) => Text(
                                              '• $item',
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
                                'Systemic disease:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: TextField(
                                controller: TextEditingController(
                                  text:
                                      patientDetails?.getSystemicDisease ?? '',
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
                            ListTile(
                              title: const Text(
                                'Risk Habits:',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: "Rubik",
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: patientDetails!.getRiskFactors
                                        ?.map((item) => Text(
                                              '• Habit: ${item.habit},\n  Frequency: ${item.frequency},\n  Duration: ${item.duration}',
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
                                'Created At:',
                                style: TextStyle(
                                  fontSize: 18,
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
                                  fontSize: 18,
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
                              child: Text(
                                'Open pdf ${patientDetails?.getConsentForm ?? ''}',
                                style: const TextStyle(
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
              const Expanded(
                child: SizedBox(),
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(50.w, 20.h, 20.w, 0.h),
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
                        child: Text(
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
                  padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
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

// class ForwardSheet extends StatelessWidget {
//   final String patientId;
//   final String patientName;
//   final ScrollController scrollController;
//
//   const ForwardSheet({
//     super.key,
//     required this.patientId,
//     required this.patientName,
//     required this.scrollController,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
//         gradient: LinearGradient(
//           colors: [
//             Color(0xFF87CEFA), // Light sky blue
//             Colors.white, // White
//           ],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Share With,',
//               style: TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Rubik',
//                   color: Color.fromARGB(255, 73, 113, 147)),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(
//                   Icons.search,
//                   color: Color.fromARGB(255, 73, 113, 147),
//                 ),
//                 hintText: 'Search',
//                 hintStyle: TextStyle(
//                   color:
//                       const Color.fromARGB(255, 73, 113, 147).withOpacity(0.5),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: BorderSide(
//                       color: const Color.fromARGB(255, 73, 113, 147)
//                           .withOpacity(
//                               0.5)), // Color of the border when focused
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                   borderSide: const BorderSide(
//                       color:
//                           Colors.white), // Color of the border when not focused
//                 ),
//                 filled: true,
//                 fillColor: Colors.white,
//                 contentPadding: const EdgeInsets.all(10.0),
//               ),
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Suggested,',
//               style: TextStyle(
//                   fontSize: 18,
//                   fontFamily: 'Rubik',
//                   color: Color.fromARGB(255, 73, 113, 147)),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 _circularImage('lib/images/sampleDoc.jpg'),
//                 _circularImage('lib/images/sampleDoc.jpg'),
//                 _circularImage('lib/images/sampleDoc.jpg'),
//                 _circularImage('lib/images/sampleDoc.jpg'),
//                 _circularImage('lib/images/sampleDoc.jpg'),
//               ],
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Patient: #12345',
//               style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: 'Rubik',
//                   color: Color.fromARGB(255, 73, 113, 147)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 enabledBorder: OutlineInputBorder(
//                   borderSide:
//                       const BorderSide(color: Color.fromARGB(255, 0, 179, 255)),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: const BorderSide(
//                       color: Color.fromARGB(255, 255, 255, 255)),
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.white, // Background color of the TextField
//                 hintText: "Add a note",
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//               ),
//               style: const TextStyle(
//                 fontSize: 16, // Adjust the font size
//               ),
//               maxLines: 10, // Adjust the number of lines
//               minLines: 1, // Adjust the number of lines
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               'Warning!',
//               style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                   //  fontFamily: 'Rubik',
//                   color: Color.fromARGB(255, 255, 0, 0)),
//             ),
//             const Text(
//               'This data only includes patient’s report details only!. Anyother personal details cannot forward through this method!',
//               style: TextStyle(
//                   fontSize: 17,
//                   fontFamily: 'Rubik',
//                   color: Color.fromARGB(255, 255, 0, 0)),
//             ),
//             const SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.only(left: 130),
//               child: Row(
//                 children: [
//                   Center(
//                     child: MyButton2(
//                       onTap: () {
//                         Navigator.pop(context); // Close the bottom sheet
//                       },
//                       text: 'Send',
//                       backgroundColor: const Color.fromARGB(255, 90, 160, 225),
//                       width: 120.0,
//                       height: 60.0,
//                     ),
//                   ),
//                   const SizedBox(width: 20),
//                   const Icon(
//                     Icons.send, // Replace with your desired icon
//                     size: 30.0, // Adjust the size as needed
//                     color: Color.fromARGB(
//                         255, 56, 122, 183), // Change the color if necessary
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget _circularImage(String imagePath) {
//   return ClipOval(
//     child: Image.asset(
//       imagePath,
//       width: 60, // You can adjust the size
//       height: 60, // You can adjust the size
//       fit: BoxFit.cover,
//     ),
//   );
// }
