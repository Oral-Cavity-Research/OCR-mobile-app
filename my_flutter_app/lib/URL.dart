import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:my_flutter_app/dto/ReviewRequestDto.dart';
import 'package:my_flutter_app/dto/ReviewerDetailsDto.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';
import 'package:my_flutter_app/dto/VerifyResponse.dart';
import 'dto/HabbitDto.dart';
import 'dto/RiskFactors.dart';
import 'dto/TeleconEntryRequest.dart';

class URL {
  static const String BASE_URL = "http://10.30.10.123:8080/api";
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
    String hospital, String registration, String designation) async {
  const url = URL.BASE_URL + "/auth/signup";
  final uri = Uri.parse(url);
  final response = await http.post(
    uri,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'reg_no': registration,
      'username': username,
      'email': email,
      'hospital': hospital,
      'designation': designation,
      'contact_no': phoneNumber,
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
  final url = URL.BASE_URL + "/user/upload/images/$teleconEntryId";
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
          'image_name': imageName + '.jpg', //add the image type
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

Future<http.Response> receivedTeleconEntries(int pageNo,String filter)async{ //Refactor to all teleconEntries
  final url = URL.BASE_URL + '/user/entry/get?page=${pageNo.toString()}&filter=${Uri.encodeComponent(filter)}';
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create telecon entry. Status code: ${response.statusCode}');
  }
}

// share these telecon entries of patient to other clinicians
Future<http.Response> shareTeleconEntries(
    int pageNo, String filter, String id) async {
  final url = URL.BASE_URL +
      '/user/entry/get/patient/${id}?page=${pageNo.toString()}&filter=${Uri.encodeComponent(filter)}';
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create telecon entry. Status code: ${response.statusCode}');
  }
}
//Get shared telecon Netry details
Future<http.Response> sharedTeleconEntryDetails(String teleconId)async{
  final url = URL.BASE_URL + '/user/entry/shared/${teleconId}';
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create retrieve data. Status code: ${response.statusCode}');
  }
}

//delete telecon Entry
Future<int> deleteEntry(String teleconId) async {
  final url = URL.BASE_URL + "/user/entry/delete/${teleconId}";
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.post(
    uri,
    headers: {'Authorization': 'Bearer ${token}', 'email': email},
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    throw Exception(
        'Failed to delete telecon entry. Status code:${teleconId} ${response.statusCode}');
  }
}

//add reviewer to the entry
///reviewer/add/{id}
Future<int> addReviewer(String teleconId, String reviewerId) async {
  final url = URL.BASE_URL + "/user/entry/reviewer/add/${teleconId}";
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'reviewer_id': reviewerId}),
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    throw Exception(
        'Failed to add reviewer. Status code: ${response.statusCode}');
  }
}

Future<int> removeReviewer(String teleconId, String reviewerId) async {
  final url = URL.BASE_URL + "/user/entry/reviewer/remove/${teleconId}";
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'reviewer_id': reviewerId}),
  );
  if (response.statusCode == 200) {
    return response.statusCode;
  } else {
    throw Exception(
        'Failed to add reviewer. Status code: ${response.statusCode}');
  }
}

//Telecon entries shared to the user
///api/user/entry/shared/all?page=1&filter=All
Future<http.Response> sharedTeleconEntries(int pageNo, String filter) async {
  final url = URL.BASE_URL +
      '/user/entry/shared/all?page=${pageNo.toString()}&filter=${Uri.encodeComponent(filter)}';
  final uri = Uri.parse(url);
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();
  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create telecon entry. Status code: ${response.statusCode}');
  }
}

// /api/user/upload/reports
Future<int> reportUpload(
  String teleconEntryId,
  String reportName,
  File file,
) async {
  final url = URL.BASE_URL + "/user/upload/reports/$teleconEntryId";
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

//creating a teleconsultation entry
Future<http.Response> createTeleconEntry(
    String startTime,
    String endTime,
    String complaints,
    String finding,
    List<HabbitDto> currentHabits,
    String PatientId) async {
  final url = URL.BASE_URL +
      "/user/entry/add/$PatientId"; //patient id should be added here
  final uri = Uri.parse(url);
  //getting the token and email of the clinician
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();

  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  //creating teleconEntryRequest instance
  TeleconEntryRequest entryRequest = TeleconEntryRequest(
      startTime: startTime,
      endTime: endTime,
      complaint: complaints,
      findings: finding,
      currentHabits: currentHabits);

  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(entryRequest.toJson()),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create telecon entry. Status code: ${response.statusCode}');
  }
}

//
Future<http.Response> addReview(
    String provisionalDiagnosis,
    String managementSuggestions,
    String referralSuggestions,
    String otherComments,
    String teleconId) async {
  final url = URL.BASE_URL +
      "/user/entry/review/${teleconId}"; //patient id should be added here
  final uri = Uri.parse(url);
  //getting the token and email of the clinician
  String? token = TokenStorage().getToken();
  String? email = TokenStorage().getEmail();

  if (token == null || email == null) {
    throw Exception("No token or email found. Please log in again");
  }
  //creating teleconEntryRequest instance
  ReviewRequest reviewRequest = ReviewRequest(
    provisionalDiagnosis: provisionalDiagnosis,
    managementSuggestions: managementSuggestions,
    referralSuggestions: referralSuggestions,
    otherComments: otherComments,
  );

  final response = await http.post(
    uri,
    headers: {
      'Authorization': 'Bearer ${token}',
      'email': email,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(reviewRequest.toJson()),
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception(
        'Failed to create telecon entry. Status code: ${response.statusCode}');
  }
}

///api/user/patient/reviewer/all
Future<List<ReviewerDetails>> getAllReviewers() async {
  const url = URL.BASE_URL + "/user/patient/reviewer/all";
  final uri = Uri.parse(url);
  final response = await http.get(
    uri,
    headers: {
      'Authorization': 'Bearer ${TokenStorage().getToken()}',
      'email': TokenStorage().getEmail()!,
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> reviewersJson = jsonDecode(response.body);
    List<ReviewerDetails> reviewerList =
        reviewersJson.map((json) => ReviewerDetails.fromJson(json)).toList();
    return reviewerList;
  } else {
    throw Exception(
        'Failed to retrieve Reviewers. Status Code : ${response.statusCode}');
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
