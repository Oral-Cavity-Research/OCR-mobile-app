import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
          ),
          const Positioned(
            top: 200,
            right: 90,
            child: Column(
              children: const [
                Center(
                  child: Text(
                    'OASIS',
                    style: TextStyle(
                      fontSize: 75,
                      color: Color.fromARGB(255, 46, 74, 95),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Teledensititry',
                    style: TextStyle(
                      fontSize: 45,
                      color: Color.fromARGB(255, 46, 74, 95),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 150),
              child: ClipOval(
                child: Container(
                  width: 500.0, // Adjust the size as needed
                  height: 300.0, // Adjust the size as needed
                  child: Lottie.asset('lib/animation/welcome.json'),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 620),
            child: Center(
              child: Text(
                'Paperless. Effortless. Digitalize',
                style: TextStyle(
                  fontSize: 25,
                  color: Color.fromARGB(255, 46, 74, 95),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'EduAUVICWANTHand',
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
              child: const Text(
                '@mobile version of OASIS',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 89, 102, 121),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              width: 150, // Adjust the size as needed
              height: 150, // Adjust the size as needed
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 103, 136, 157).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 100,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Image.asset(
                'lib/images/icon1light.png',
                width: 150, // Adjust the size as needed
                height: 150, // Adjust the size as needed
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}
