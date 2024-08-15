import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/pages/add_methods/add_patientPage.dart';
import 'package:my_flutter_app/pages/add_methods/add_rolePage.dart';
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:my_flutter_app/pages/auth/logout_page.dart';
import 'package:my_flutter_app/pages/auth/route_generator.dart';
import 'package:my_flutter_app/pages/auth/signin_page.dart';
import 'package:my_flutter_app/pages/auth/welcome_page.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/home/recievedFiles_page.dart';
import 'package:my_flutter_app/pages/home/sentFiles_page.dart';
import 'package:my_flutter_app/pages/profiles/patientProfilePage.dart';

import 'package:my_flutter_app/pages/search/searchPage.dart';
import 'package:my_flutter_app/pages/aboutUs/aboutUs.dart';
import 'package:my_flutter_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

import 'pages/imageUpload/image_upload.dart';

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
    return ScreenUtilInit(
      designSize: const Size(415, 923),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/', // Set SearchPage as the home page for preview
        theme: Provider.of<ThemeProvider>(context).themeData,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
