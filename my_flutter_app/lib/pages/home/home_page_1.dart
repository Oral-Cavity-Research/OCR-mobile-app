import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/menu_button.dart';
import 'package:my_flutter_app/components/my_dropdown_bar.dart';
import 'package:my_flutter_app/components/user_notification_1.dart';
import 'package:my_flutter_app/pages/aboutUs/about_us.dart';
import 'package:my_flutter_app/pages/add_methods/add_role_page.dart';
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:my_flutter_app/pages/profiles/doctor_profile_page.dart';

import '../imageUpload/ImageUploadScreen.dart';
import '../patient/patient_upload.dart';

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
  List<String> patientNames = [];
  

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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

  void switchOption(String menuItem) {
    switch (menuItem) {
      case 'See Profile':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DoctorProfilePage()),
        );
        toggleMenu();
        break;
      // other cases
      case 'Upload Image':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ImageUploadForm()),
        );
        toggleMenu();
        break;

      case 'Add a Doctor':
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AddRole(
                    onTap: () {},
                  )),
        );
        toggleMenu();
        break;

      case 'Upload Patient':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PatientConsentForm()),
        );
        toggleMenu();
        break;

      default:
        // handle other menu items
        break;
    }
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
                // Container(
                //   height: 100,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Color.fromARGB(255, 59, 158, 215), // Dodger blue
                //         Color.fromARGB(255, 122, 188, 245), // Royal blue
                //       ],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Color.fromARGB(66, 255, 255, 255),
                //         blurRadius: 10,
                //         offset: Offset(0, 5),
                //       ),
                //     ],
                //   ),
                //   child: Padding(
                //     padding: EdgeInsets.fromLTRB(50.w, 30.h, 0.w, 0.h),
                //     child: Row(
                //       children: [
                //         const Spacer(),
                //         const Text(
                //           'Home',
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 24,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //         const Spacer(),
                //         IconButton(
                //           icon: const Icon(Icons.arrow_forward,
                //               color: Colors.white),
                //           onPressed: () {},
                //         ),
                //       ],
                //     ),
                //   ),
                // ),

                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const Text(
                        "RECENTS",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      buildReportCard(),
                      buildReportCard(),
                      SizedBox(height: 32),
                      const Text(
                        "RECOMMENDED",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      buildReportCard(),
                      buildReportCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // if (isMenuOpen)
          //   AnimatedOpacity(
          //     opacity: isMenuOpen ? 1.0 : 0,
          //     duration: Duration(microseconds: 300),
          //     child: GestureDetector(
          //       onTap: toggleMenu,
          //       child: Container(
          //         color: Colors.black.withOpacity(0.5),
          //         child: BackdropFilter(
          //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          //           child: Container(
          //             color: Colors.black.withOpacity(0.2),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // SlideTransition(
          //   position: _offsetAnimation,
          //   child: Container(
          //     width: 250,
          //     padding: const EdgeInsets.only(top: 110),
          //     decoration: const BoxDecoration(
          //       color: Color.fromARGB(255, 3, 7, 11),
          //       image: DecorationImage(
          //         image: AssetImage('lib/images/whatsappBack.jpg'),
          //         fit: BoxFit.cover,
          //       ),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.black26,
          //           blurRadius: 10,
          //           offset: Offset(0, 5),
          //         ),
          //       ],
          //       borderRadius: BorderRadius.only(
          //         topRight: Radius.circular(20),
          //         bottomRight: Radius.circular(20),
          //       ),
          //     ),
          //     // child: ListView(
          //     //   padding: EdgeInsets.zero,
          //     //   children: [
          //     //     buildMenuButton(Icons.person, 'See Profile',
          //     //         () => switchOption('See Profile')),
          //     //     buildMenuButton(Icons.add, 'Add a Patient', add_patient),
          //     //     buildMenuButton(Icons.add, 'Add a Doctor', toggleMenu),
          //     //     buildMenuButton(Icons.remove, 'Remove a Doctor', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Consultant', toggleMenu),
          //     //     buildMenuButton(
          //     //         Icons.remove, 'Remove a Consultant', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Role', add_role),
          //     //     buildMenuButton(Icons.logout, 'Log Out', googleSignOut),
          //     //     buildMenuButton(Icons.info, 'About Us', about_us),
          //     //     buildMenuButton(Icons.add, 'Upload Image', imageUpload)
          //     //   ],
          //     // ),
          //   ),
          // ),
          // Positioned(
          //   top: 35,
          //   left: 16,
          //   child: GestureDetector(
          //     onTap: toggleMenu,
          //     child: Container(
          //       height: 55.0,
          //       width: 55.0,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           color: Colors.white,
          //           width: 1.3,
          //         ),
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.black.withOpacity(0.2),
          //             spreadRadius: 1,
          //             blurRadius: 6,
          //             offset: const Offset(0, 4),
          //           ),
          //         ],
          //       ),
          // child: ClipOval(
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          //       splashColor: Colors.white24,
          //       onTap: toggleMenu,
          //       child: Image.asset(
          //         'lib/images/icon1.png',
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
