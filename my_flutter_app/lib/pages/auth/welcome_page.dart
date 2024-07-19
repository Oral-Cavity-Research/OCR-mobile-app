import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/my_button.dart';

class WelcomePage extends StatefulWidget {
  final void Function()? onTap;

  const WelcomePage({super.key, required this.onTap});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 224, 235, 250),
              Color.fromARGB(255, 152, 195, 235),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.only(top: 150, bottom: 50),
                child: const Text(
                  'WELCOME!',
                  style: TextStyle(
                    fontSize: 35,
                    color: Color.fromARGB(255, 56, 76, 111),
                    fontFamily: 'PlaywriteCU',
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        color: Color.fromARGB(255, 134, 139, 148),
                        offset: Offset(3, 3),
                        blurRadius: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'to ',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color.fromARGB(255, 56, 76, 111),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'OASIS',
                  style: TextStyle(
                    fontSize: 50,
                    color: Color.fromARGB(255, 56, 76, 111),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'Teledentistry',
                  style: TextStyle(
                    fontSize: 40,
                    color: Color.fromARGB(255, 56, 76, 111),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PlayfairDisplay',
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(135, 30, 0, 0),
              child: const Image(
                image: AssetImage('lib/images/icon1.png'),
                width: 180,
                height: 180,
              ),
            ),
            Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 20, 40, 0),
                child: const Text(
                  'Admin will accept you request',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 56, 76, 111),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 30), // Add padding between buttons
                  MyButton(
                    onTap: () {
                      // Handle button tap
                      print('Log in button tapped!');
                    },
                    text: 'Log in',
                    backgroundColor:
                        const Color.fromARGB(255, 4, 20, 52), // Solid color
                    width: 350.0, // Custom width
                    height: 45.0, // Custom height
                  ),
                  const SizedBox(height: 5), // Add padding between buttons
                  MyButton(
                    onTap: () {
                      // Handle button tap
                      print('Cancel button tapped!');
                    },
                    text: 'Cancel',
                    backgroundColor:
                        const Color.fromARGB(255, 4, 79, 141), // Solid color
                    width: 350.0, // Custom width
                    height: 45.0, // Custom height
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
