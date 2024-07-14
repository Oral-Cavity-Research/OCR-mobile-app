import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
