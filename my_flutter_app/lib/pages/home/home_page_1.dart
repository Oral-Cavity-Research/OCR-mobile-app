import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  bool isMenuOpen = false;

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
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
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
                  Color.fromARGB(255, 138, 179, 250),
                  Color.fromARGB(255, 46, 189, 255)
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF448AFF), Colors.lightBlueAccent],
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
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
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
                        icon: Icon(Icons.menu, color: Colors.white),
                        onPressed: toggleMenu,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16),
                    children: [
                      // Recents Section
                      Text(
                        'RECENTS',
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
                      // Recommended Section
                      Text(
                        'Recommended',
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
          // Blur and darken effect
          if (isMenuOpen)
            AnimatedOpacity(
              opacity: isMenuOpen ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
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
          // Sliding Menu
          SlideTransition(
            position: _offsetAnimation,
            child: Container(
              width: 250,
              padding: EdgeInsets.symmetric(vertical: 40),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 152, 195, 235),
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
                padding: EdgeInsets.only(top: 50),
                children: [
                  buildMenuButton(Icons.person, 'See Profile'),
                  buildMenuButton(Icons.add, 'Add a Patient'),
                  buildMenuButton(Icons.add, 'Add a Doctor'),
                  buildMenuButton(Icons.remove, 'Remove a Doctor'),
                  buildMenuButton(Icons.add, 'Add a Consultant'),
                  buildMenuButton(Icons.remove, 'Remove a Consultant'),
                  buildMenuButton(Icons.add, 'Add a Role'),
                  buildMenuButton(Icons.logout, 'Log Out'),
                  buildMenuButton(Icons.info, 'About Us'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReportCard() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      shadowColor: Colors.black26,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'lib/images/image.jpg',
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Name: Sahan Dissanayake',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('Age: 34'),
            Text('ID: ABCD'),
            Text('District: Kandy'),
            Text('Date: 12/12/2022'),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 16),
          foregroundColor: Colors.blue,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          shadowColor: Colors.black26,
        ),
        icon: Icon(icon, color: Colors.blue),
        label: Text(title, style: TextStyle(color: Colors.blue)),
        onPressed: () {
          // Handle button tap here
          toggleMenu();
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
