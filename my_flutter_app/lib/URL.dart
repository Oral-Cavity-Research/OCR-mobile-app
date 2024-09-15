import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_flutter_app/model/hospitalModel.dart';

class URL {
  static const String BASE_URL = "http://10.0.2.2:8080/api";
}

// /user/self/hospitals
Future<List<String>> hospitallist() async {
  const url = URL.BASE_URL + "/user/self/hospitals";
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  final body = response.body;
  final List<dynamic> json = jsonDecode(body);

  List<String> hospitalsNames = [];

  for (var hospital in json) {
    String name = hospital['name'] ?? 'Unknown Hospital';
    hospitalsNames.add(name);
  }

  return hospitalsNames;
}

// /api/auth/signup
Future<int> signup(String email, String username, String phoneNumber,
    String hospital, String registration) async {
  const url = URL.BASE_URL + "/auth/signup";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'username': username,
      'contact_no': phoneNumber,
      'hospital': hospital,
      'reg_no': registration,
      'designation': 'Dr.',
    }),
  );

  return response.statusCode;
}

// /api/auth/verify

Future<int> verify(String email) async {
  const url = URL.BASE_URL + "/auth/verify";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
    }),
  );

  return response.statusCode;
}

Future<List<String>> user_details(String response) async {
  final List<dynamic> json = jsonDecode(response);

  List<String> userDetails = [];

  for (var user in json) {
    String name = user['name'] ?? 'Unknown User';
    String email = user['email'] ?? 'Unknown Email';
    String phone = user['phone'] ?? 'Unknown Phone';
    String hospital = user['hospital'] ?? 'Unknown Hospital';
    String reg_no = user['reg_no'] ?? 'Unknown Reg No';
    String designation = user['designation'] ?? 'Unknown Designation';

    userDetails.add(name);
    userDetails.add(email);
    userDetails.add(phone);
    userDetails.add(hospital);
    userDetails.add(reg_no);
    userDetails.add(designation);
  }

  return userDetails;
}