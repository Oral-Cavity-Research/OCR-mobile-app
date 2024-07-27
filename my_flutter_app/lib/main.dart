import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/add_methods/add_patientPage.dart';
import 'package:my_flutter_app/pages/add_methods/add_rolePage.dart';
import 'package:my_flutter_app/pages/auth/loadingScreen.dart';
import 'package:my_flutter_app/pages/auth/logout_page.dart';
import 'package:my_flutter_app/pages/auth/welcome_page.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/home/recievedFiles_page.dart';
import 'package:my_flutter_app/pages/home/sentFiles_page.dart';
import 'package:my_flutter_app/pages/profiles/patientProfilePage.dart';
import 'package:my_flutter_app/pages/profiles/doctorProfilePage.dart';
import 'package:my_flutter_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PatientProfile(
        onTap: () {},
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
