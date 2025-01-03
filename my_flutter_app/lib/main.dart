import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/controller/DataProvider.dart';
import 'package:my_flutter_app/modals/Patient.dart';
import 'package:my_flutter_app/pages/auth/route_generator.dart';

import 'package:my_flutter_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ChangeNotifierProvider(
          create: (context) => Patient(
              id: 'sample',
              patientId: 'sample',
              patientName: 'sample',
              dob: 'sample',
              gender: 'sample')),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(420, 933),
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
