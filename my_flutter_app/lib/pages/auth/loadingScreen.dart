import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              //  Color.fromARGB(255, 92, 163, 230),
              Color.fromARGB(255, 101, 174, 244),
              Color.fromARGB(255, 148, 192, 233),
              //   Color.fromARGB(255, 152, 195, 235),
              Color.fromARGB(255, 206, 219, 239),
            ],
          ),
        ),
        child: Center(
          child: ClipOval(
            child: Container(
              width: 500.0, // Adjust the size as needed
              height: 300.0, // Adjust the size as needed
              child: Lottie.asset('lib/animation/welcome.json'),
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: WelcomeScreen(),
  ));
}
