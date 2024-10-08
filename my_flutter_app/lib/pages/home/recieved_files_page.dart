import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/doctor_notification.dart';
import 'package:my_flutter_app/components/menu_button.dart';

class RecievFiles extends StatefulWidget {
  const RecievFiles({super.key});

  @override
  _RecievFilesState createState() => _RecievFilesState();
}

class _RecievFilesState extends State<RecievFiles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isMenuOpen = false;
  int _selectedIndex = 0;

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
                // Container(
                //   height: 100,
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   decoration: const BoxDecoration(
                //     gradient: LinearGradient(
                //       colors: [
                //         Color.fromARGB(255, 87, 199, 255), // Dodger blue
                //         Color.fromARGB(255, 110, 133, 236), // Royal blue
                //       ],
                //       begin: Alignment.topLeft,
                //       end: Alignment.bottomRight,
                //     ),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.black26,
                //         blurRadius: 10,
                //         offset: Offset(0, 5),
                //       ),
                //     ],
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.only(top: 30),
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
                      // const Text(
                      //   "RECIEVED FILES",
                      //   style: TextStyle(
                      //     fontFamily: 'Rubik',
                      //     fontSize: 24,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      const SizedBox(height: 16),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                      buildDoctorNotification('DOC_ID: #12345',
                          'Patient_id: 5454345', 'Date: 12/12/2022'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMenuOpen)
            AnimatedOpacity(
              opacity: isMenuOpen ? 1.0 : 0,
              duration: const Duration(microseconds: 300),
              child: GestureDetector(
                onTap: toggleMenu,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            ),
          // SlideTransition(
          //   position: _offsetAnimation,
          //   child: Container(
          //     width: 250,
          //     padding: const EdgeInsets.only(top: 110),
          //     decoration: const BoxDecoration(
          //       color: Color.fromARGB(255, 152, 195, 235),
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
          //     //     buildMenuButton(Icons.person, 'See Profile', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Patient', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Doctor', toggleMenu),
          //     //     buildMenuButton(Icons.remove, 'Remove a Doctor', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Consultant', toggleMenu),
          //     //     buildMenuButton(
          //     //         Icons.remove, 'Remove a Consultant', toggleMenu),
          //     //     buildMenuButton(Icons.add, 'Add a Role', toggleMenu),
          //     //     buildMenuButton(Icons.logout, 'Log Out', toggleMenu),
          //     //     buildMenuButton(Icons.info, 'About Us', toggleMenu),
          //     //   ],
          //     // ),
          //   ),
          // ),
          // Positioned(
          //   top: 30,
          //   left: 16,
          //   child: GestureDetector(
          //     onTap: toggleMenu,
          //     child: Container(
          //       height: 65.0,
          //       width: 65.0,
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           color: Colors.white,
          //           width: 2.0,
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
          //       child: ClipOval(
          //         child: Material(
          //           color: Colors.transparent,
          //           child: InkWell(
          //             splashColor: Colors.white24,
          //             onTap: toggleMenu,
          //             child: Image.asset(
          //               'lib/images/icon1.png',
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
