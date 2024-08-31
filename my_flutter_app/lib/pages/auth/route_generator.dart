import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:my_flutter_app/pages/auth/Signin_page.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const GoogleSignIN());
      case '/signin':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => SigninPage(
              email: args,
            ),
          );
        }
        return _errorRoute();
      case '/HomePage':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}