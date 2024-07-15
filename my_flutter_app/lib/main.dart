import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/auth/login_page.dart';
import 'package:my_flutter_app/pages/auth/welcome_page.dart';
import 'package:my_flutter_app/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'pages/auth/signin_page.dart';

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
      home: LoginPage(
        onTap: () {},
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
