// aboutUs/aboutUs.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.05),
                    //     spreadRadius: 2,
                    //     blurRadius: 10,
                    //     blurStyle: BlurStyle.inner,
                    //   ),
                    // ],
                  ),
                  child: Image.asset('lib/images/icon1light.png', height: 200),
                ), // Add your logo image to assets folder and update path
                const SizedBox(height: 20),
                Text(
                  'About Us',
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'We are a team of passionate individuals dedicated to crafting innovative engineering solutions for everyday challenges.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 89, 102, 121),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik',
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Our mission is to harness our collective expertise and creativity to develop practical, efficient, and sustainable solutions that make a positive impact on people\'s lives.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Thank You !!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '@mobile version of OASIS',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AboutUsPage(),
  ));
}
