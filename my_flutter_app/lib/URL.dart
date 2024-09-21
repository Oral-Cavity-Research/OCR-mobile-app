import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';

import 'package:my_flutter_app/dto/VerifyResponse.dart';
import 'package:my_flutter_app/model/hospitalModel.dart';

import 'dto/RiskFactors.dart';

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
  hospitalsNames.add('Other');

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
      'designation': '',
    }),
  );

  return response.statusCode;
}

// /api/user/upload/images
Future<int> imageUpload(
  String teleconEntryId,
  String imageName,
  String location,
  String clinicalDiagnosis,
  bool lesionsAppear,
  String predictedCat,
  File file,
) async {
  const url = URL.BASE_URL + "/user/upload/images/6426fef2906bd94313ebe93d";
  final dio.Dio dioClient = dio.Dio(); // Initialize Dio

  // Get the token from the token storage
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();

  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }

  try {
    // Prepare the multipart form data
    dio.FormData formData = dio.FormData.fromMap({
      "files": await dio.MultipartFile.fromFile(
        file.path,
        filename: imageName, // Use the image name as the file name
      ),
      "data": dio.MultipartFile.fromString(
        jsonEncode({
          'telecon_entry_id': teleconEntryId,
          'image_name': imageName,
          'location': location,
          'clinical_diagnosis': clinicalDiagnosis,
          'lesions_appear': lesionsAppear.toString(),
          'predicted_cat': predictedCat,
        }),
        contentType: MediaType.parse('application/json'),
      ),
    });

    // Make the request with authorization and email headers
    dio.Response response = await dioClient.post(
      url,
      data: formData,
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
          'email': email,
        },
      ),
    );

    // Check if the response status code is successful (200-299)
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed. Status code: ${response.statusCode}');
    }

    return response.statusCode!;
  } catch (dioError) {
    // Log more details for the error
    if (dioError is dio.DioError && dioError.response != null) {
      print('Error uploading file: ${dioError.message}');
      print('Response data: ${dioError.response?.data}');
      print('Response status code: ${dioError.response?.statusCode}');
    } else {
      print('Unexpected error: $dioError');
    }
    return 500; // Return an error status code if something goes wrong
  }
}


// /api/user/upload/reports
Future<int> reportUpload(
    String teleconEntryId,
    String reportName,
    File file,
    ) async {
  const url = URL.BASE_URL + "/user/upload/reports/6426fef2906bd94313ebe93d";
  final dio.Dio dioClient = dio.Dio(); // Initialize Dio

  // Get the token from the token storage
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();

  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }

  try {
    // Prepare the multipart form data
    dio.FormData formData = dio.FormData.fromMap({
      "files": await dio.MultipartFile.fromFile(
        file.path,
        filename: reportName, // Use the image name as the file name
      ),
      "data": dio.MultipartFile.fromString(
        jsonEncode({
          'telecon_entry_id': teleconEntryId,
          'report_name': reportName,
        }),
        contentType: MediaType.parse('application/json'),
      ),
    });

    // Make the request with authorization and email headers
    dio.Response response = await dioClient.post(
      url,
      data: formData,
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
          'email': email,
        },
      ),
    );
    return response.statusCode!;
  } catch (dioError) {
    // Log more details for the error
    if (dioError is dio.DioError && dioError.response != null) {
      print('Error uploading file: ${dioError.message}');
      print('Response data: ${dioError.response?.data}');
      print('Response status code: ${dioError.response?.statusCode}');
    } else {
      print('Unexpected error: $dioError');
    }
    return 500; // Return an error status code if something goes wrong
  }
}


// /api/user/upload/patient
Future<int> patientUpload(
    String patientId,
    String clinicianId,
    String patientName,
    List<RiskFactors> riskFactors,
    String dob,
    String gender,
    String histoDiagnosis,
    List<String> medicalHistory,
    List<String> familyHistory,
    String systemicDisease,
    String contactNo,
    String consentForm,
    File file,
    String patientIdFromHeaders) async {
  const url = URL.BASE_URL + "/user/upload/patient";
  final dio.Dio dioClient = dio.Dio(); // Initialize Dio

  // Get the token from the token storage
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();

  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }

  try {
    // Prepare the multipart form data
    dio.FormData formData = dio.FormData.fromMap({
      "files": await dio.MultipartFile.fromFile(
        file.path,
        filename:
            "$patientIdFromHeaders.pdf", // Use the patientId as the file name
      ),
      "data": dio.MultipartFile.fromString(
        jsonEncode({
          'patient_id': patientId,
          'clinician_id': clinicianId,
          'patient_name': patientName,
          'risk_factors': riskFactors.map((e) => e.toJson()).toList(),
          'DOB': dob,
          'gender': gender,
          'histo_diagnosis': histoDiagnosis,
          'medical_history': medicalHistory,
          'family_history': familyHistory,
          'systemic_disease': systemicDisease,
          'contact_no': contactNo,
          'consent_form': consentForm,
        }),
        contentType: MediaType.parse('application/json'),
      ),
      "patient_id": dio.MultipartFile.fromString(patientIdFromHeaders)
    });

    // Make the request with authorization and email headers
    dio.Response response = await dioClient.post(
      url,
      data: formData,
      options: dio.Options(
        headers: {
          'Authorization': 'Bearer $token',
          'email': email,
        },
      ),
    );

    // Check if the response status code is successful (200-299)
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      print('Consent Form uploaded successfully');
    } else {
      print('Consent Form  upload failed. Status code: ${response.statusCode}');
    }

    return response.statusCode!;
  } catch (dioError) {
    // Log more details for the error
    if (dioError is dio.DioError && dioError.response != null) {
      print('Error uploading file: ${dioError.message}');
      print('Response data: ${dioError.response?.data}');
      print('Response status code: ${dioError.response?.statusCode}');
    } else {
      print('Unexpected error: $dioError');
    }
    return 500; // Return an error status code if something goes wrong
  }
}

Future<VerifyResponse> verify(String email, String photoUrl) async {
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
  TokenStorage().setUserImage(photoUrl);
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
