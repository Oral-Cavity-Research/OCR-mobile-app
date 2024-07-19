import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_app/components/menubutton.dart';
import 'package:my_flutter_app/components/user_notification_1.dart';

class HomePage extends StatefulWidget {
  // const MyWidget({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  late AnimationController
      _controller; // = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  late Animation<Offset>
      _offsetAnimation; // = Tween<Offset>(begin: Offset(0, 0), end: Offset(0.5, 0)).animate(_controller);
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
            begin: Offset(-1.0, 0.0), end: Offset(0.0, 0.0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
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
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 77, 196, 243), // Sky blue
                Color(0xFF87CEFA), // Light sky blue
                Colors.white, // White
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
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
                        "RECENTS",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      buildReportCard(),
                      buildReportCard(),
                      SizedBox(height: 32),
                      Text(
                        "RECOMMENDED",
                        style: TextStyle(
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
              padding: EdgeInsets.only(
                  top: 110), // Adjust padding to start below app bar
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
                padding: EdgeInsets.zero, // Remove additional padding
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
              onTap: toggleMenu, // This will handle the button press
              child: Container(
                height: 65.0, // Adjust the size as needed
                width: 65.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle, // Makes the border circular
                  border: Border.all(
                    color: Colors.white, // Border color
                    width: 2.0, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 1, // How much the shadow spreads
                      blurRadius: 6, // How blurry the shadow is
                      offset:
                          Offset(0, 4), // Shadow offset (horizontal, vertical)
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Material(
                    color:
                        Colors.transparent, // Make Material color transparent
                    child: InkWell(
                      splashColor: Colors.white24, // Splash color on tap
                      onTap: toggleMenu,
                      child: Image.asset(
                        'lib/images/icon1.png',
                        fit: BoxFit
                            .cover, // Ensures the image fits within the circular shape
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
