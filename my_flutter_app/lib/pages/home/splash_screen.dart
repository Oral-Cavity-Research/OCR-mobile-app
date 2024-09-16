import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushNamed(
        '/login',
      );
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

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
            top: 170,
            right: 70,
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
                  width: 500.w, // Adjust the size as needed
                  height: 300.h, // Adjust the size as needed
                  child: Lottie.asset('lib/animation/welcome.json'),
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 500),
            child: Center(
              child: Text(
                'Paperless. Effortless. Digitalize',
                style: TextStyle(
                  fontSize: 22,
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
              padding:  EdgeInsets.fromLTRB(30.w, 0.h, 40.w, 0.h),
              child: const Text(
                '@mobile version of OASIS',
                style: TextStyle(
                  fontSize: 13,
                  color: Color.fromARGB(255, 89, 102, 121),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
          ),
          Positioned(
            top: 50.h,
            right: 20.w,
            child: Container(
              width: 150.w, // Adjust the size as needed
              height: 150.h, // Adjust the size as needed
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
              child: Center(
              child: Image.asset(
                'lib/images/icon1light.png',
                width: 200.w, // Adjust the size as needed
                height: 150.h, // Adjust the size as needed
              ),
              )
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: const SplashScreen(),
  ));
}
