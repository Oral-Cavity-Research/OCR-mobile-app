import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_app/components/doctorNotification.dart';
import 'package:my_flutter_app/components/menubutton.dart';
import 'package:my_flutter_app/components/user_notification_1.dart';

class SentFiles extends StatefulWidget {
  @override
  _SentFilesState createState() => _SentFilesState();
}

class _SentFilesState extends State<SentFiles>
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
      begin: Offset(-1.0, 0.0),
      end: Offset(0.0, 0.0),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
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
                  Color.fromARGB(255, 77, 196, 243), // Sky blue
                  Color(0xFF87CEFA), // Light sky blue
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
                Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 87, 199, 255), // Dodger blue
                        Color.fromARGB(255, 110, 177, 236), // Royal blue
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      children: [
                        Spacer(),
                        Text(
                          'Home',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_forward, color: Colors.white),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        "SENT FILES",
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
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
              duration: Duration(microseconds: 300),
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
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              width: 250,
              padding: EdgeInsets.only(top: 110),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 152, 195, 235),
                image: DecorationImage(
                  image: AssetImage('lib/images/whatsappBack.jpg'),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  buildMenuButton(Icons.person, 'See Profile', toggleMenu),
                  buildMenuButton(Icons.add, 'Add a Patient', toggleMenu),
                  buildMenuButton(Icons.add, 'Add a Doctor', toggleMenu),
                  buildMenuButton(Icons.remove, 'Remove a Doctor', toggleMenu),
                  buildMenuButton(Icons.add, 'Add a Consultant', toggleMenu),
                  buildMenuButton(
                      Icons.remove, 'Remove a Consultant', toggleMenu),
                  buildMenuButton(Icons.add, 'Add a Role', toggleMenu),
                  buildMenuButton(Icons.logout, 'Log Out', toggleMenu),
                  buildMenuButton(Icons.info, 'About Us', toggleMenu),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 16,
            child: GestureDetector(
              onTap: toggleMenu,
              child: Container(
                height: 65.0,
                width: 65.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.white24,
                      onTap: toggleMenu,
                      child: Image.asset(
                        'lib/images/icon1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.send),
              label: 'Sent reports',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.call_received),
              label: 'Receive reports',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}