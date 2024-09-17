import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_flutter_app/dto/TokenStorage.dart';

import 'package:my_flutter_app/dto/VerifyResponse.dart';
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

Future<VerifyResponse> verify(String email) async {
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

  final Map<String, dynamic> responseBody = jsonDecode(response.body);

  // Extract the token
  final String token = responseBody['accessToken']['token'];
  final dynamic user = responseBody['ref'];

  TokenStorage().setToken(token);
  TokenStorage().setUser(user);
  return VerifyResponse(response.statusCode, token);
}

//add a role
Future<bool> addRole(String roleName, List<int> permissions) async {
  final url = URL.BASE_URL + "/admin/roles";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer ${TokenStorage().getToken()}',
      'email': TokenStorage().getEmail()!,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'role': roleName,
      'permissions': permissions,
    }),
  );

  if (response.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}

// ignore: non_constant_identifier_names
Future<Map<int, String>> getOptions(String optionName) async {
  // Add your code here

  final Map<int, String> optionsMap = {};
  final url = URL.BASE_URL + "/admin/option/$optionName";
  final uri = Uri.parse(url);

  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${TokenStorage().getToken()}',
      'email': TokenStorage().getEmail()!,
    },
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> responseBody = jsonDecode(response.body);
    print("ffffffffffffff");
    print(responseBody);
    print(responseBody['options']);
    List<Map<String, dynamic>> optionsList =
        List<Map<String, dynamic>>.from(responseBody['options']);
    for (var option in optionsList) {
      int value = option['value'];
      String label = option['label'];
      optionsMap[value] = label;
    }
  }
  return optionsMap;
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
