import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';
import 'package:my_flutter_app/dto/VerifyResponse.dart';
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
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
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
  print(TokenStorage().getToken());
  print(TokenStorage().getUsername());
  print(TokenStorage().getEmail());
  print(TokenStorage().getHospital());
  print(TokenStorage().getRegNo());
  print(TokenStorage().getDesignation());
  print(TokenStorage().getContactNo());
  print(TokenStorage().getRole());
  print(TokenStorage().getCreatedAt());
  print(TokenStorage().getUpdatedAt());
  print(TokenStorage().getAvailability());
  print(TokenStorage().getPassword());
  print(TokenStorage().getId());

  return VerifyResponse(response.statusCode, token);
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
