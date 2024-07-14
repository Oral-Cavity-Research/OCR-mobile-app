import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

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
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'WELCOME to Oasis Teledensity',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold),
                )),
            Container(
                padding: const EdgeInsets.only(left: 120),
                child: const Image(
                  image: AssetImage('lib/images/icon1.png'),
                  width: 200,
                  height: 200,
                ))
          ],
        ));
  }
}
