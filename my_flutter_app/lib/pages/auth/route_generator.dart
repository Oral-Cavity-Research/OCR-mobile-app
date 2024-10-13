import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/pageNav.dart';
import 'package:my_flutter_app/pages/aboutUs/about_us.dart';
import 'package:my_flutter_app/pages/add_methods/add_patient_page.dart';
import 'package:my_flutter_app/pages/add_methods/add_role_Page.dart'
    as AddRolePage;
import 'package:my_flutter_app/pages/auth/google_sign.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/auth/Signup_page.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/home/recieved_files_page.dart';
import 'package:my_flutter_app/pages/home/sent_files_page.dart';
import 'package:my_flutter_app/pages/home/splash_screen.dart';
import 'package:my_flutter_app/pages/imageUpload/ImageUploadScreen.dart';
import 'package:my_flutter_app/pages/patient/patient_upload.dart';
import 'package:my_flutter_app/pages/profiles/doctor_edit_profile.dart';

import 'package:my_flutter_app/pages/profiles/doctor_profile_page.dart';
import 'package:my_flutter_app/pages/search/search_page.dart';
import 'package:my_flutter_app/pages/search/search_page2.dart';

import '../ReportUpload/reportUploadScreen.dart';
import '../TeleconEntry/AddTeleconEntryScreen.dart';

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

      case '/pageNav':
        return MaterialPageRoute(builder: (_) => const Pagenav());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());

      case '/about_us':
        return MaterialPageRoute(builder: (_) => const AboutUsPage());

      case '/add_patient':
        return MaterialPageRoute(builder: (_) => PatientConsentForm());

      case "/search":
        print("search");
        return MaterialPageRoute(builder: (_) => SearchPage());

      case '/report_upload':
        return MaterialPageRoute(builder: (_) => const ReportUploadForm());

      case '/search':
        return MaterialPageRoute(builder: (_) => const SearchPage());

      case '/sent_reports':
        return MaterialPageRoute(builder: (_) => const SentFiles());

      case '/receive_reports':
        return MaterialPageRoute(builder: (_) => const RecievFiles());

      case '/doctor_profile':
        return MaterialPageRoute(builder: (_) => const DoctorProfilePage());

      case '/edit-profile':
        return MaterialPageRoute(builder: (_) => const DoctorEditProfile());

      case '/create_TeleconEntry':
        return MaterialPageRoute(builder: (_) => TeleconEntryForm( patientId: '66e9a9a8e6943f3d97c3279a',));

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

class DoctorProfile {
  const DoctorProfile();
}
