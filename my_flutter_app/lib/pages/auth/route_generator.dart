import 'package:flutter/material.dart';
import 'package:my_flutter_app/pages/aboutUs/about_us.dart';
import 'package:my_flutter_app/pages/add_methods/add_patient_page.dart';
import 'package:my_flutter_app/pages/add_methods/add_role_Page.dart'
    as AddRolePage;
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/auth/Signup_page.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/home/splash_screen.dart';
import 'package:my_flutter_app/pages/imageUpload/image_upload.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/login':
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


      case '/add_a_role':
        return MaterialPageRoute(
            builder: (_) => const AddRolePage.AddRole(onTap: null));

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/about_us':
        return MaterialPageRoute(builder: (_) => const AboutUsPage());
      
      case '/add_patient':
        return MaterialPageRoute(builder: (_) => const AddPatientpage(onTap: null));
      
      case '/upload_image':
        return MaterialPageRoute(builder: (_) => const ImageUploadForm());

      case '/image_upload':
        return MaterialPageRoute(builder: (_) => const ImageUploadForm());

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
