import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/Service/patient_controler.dart';
import 'package:my_flutter_app/modals/Patient.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isMenuOpen = false;
  int _selectedIndex = 0;

  GoogleSignIn signIn = GoogleSignIn();
  List<Patient> patientList = [];

  @override
  void initState() {
    super.initState();
    // Initialize to an empty list
    getRecents().then((recents) {
      setState(() {
        if (recents != null) {
          for (var patient in recents) {
            patientList.add(patient);
          }
        }
      });
    }).catchError((error) {
      print("Error fetching recents: $error");
    });
    print(patientList.toString());
  }

  void googleSignOut() async {
    try {
      await signIn.signOut();
      Navigator.pop(context);
    } catch (error) {
      print(error);
    }
  }

  void about_us() {
    Navigator.pushNamed(context, '/about_us');
  }

  void imageUpload() {
    Navigator.pushNamed(context, '/imageUploadScreen');
  }

  void add_patient() {
    Navigator.pushNamed(context, '/add_patient');
  }

  void add_role() {
    Navigator.pushNamed(context, '/add_a_role');
  }

  void add_consentform() {
    Navigator.pushNamed(context, '/patient_upload');
  }

  void add_report() {
    Navigator.pushNamed(context, '/report_upload');
  }

  void toggleMenu() {
    setState(() {
      if (isMenuOpen) {
        _controller.reverse();
      } else {
        _controller.forward();
      }
      isMenuOpen = !isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 95, 174, 213), // Sky blue
                  Color.fromARGB(255, 124, 185, 223), // Light sky blue
                  Colors.white, // White
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (isMenuOpen) {
                toggleMenu();
              }
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount:
                        patientList.length + 2, // Including "Recommended"
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Text(
                          "RECENTS",
                          style: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        );
                      } else if (index <= patientList.length) {
                        return buildReportCard(
                          key: ValueKey(patientList[index - 1]
                              .id), // Unique key for each item
                          patient: patientList[index - 1],
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildReportCard({Key? key, required Patient patient}) {
  // Example report card implementation
  return Card(
    key: key,
    margin: const EdgeInsets.symmetric(vertical: 8),
    color: Colors.white.withOpacity(0.8),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patient.patientName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text("Id: ${patient.patientId}"),
          Text("DOB: ${patient.dob}"),
          Text("Gender: ${patient.gender}"),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
