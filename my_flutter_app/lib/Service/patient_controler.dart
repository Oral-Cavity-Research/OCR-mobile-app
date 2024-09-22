import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/error_message.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';
//api functiom for recents
import 'package:my_flutter_app/modals/Patient.dart';

Future<List<Patient>?> getRecents() async {
  print('Getting recents');
  final response = await http.get(
    Uri.parse(
        "${URL.BASE_URL}/user/patient/get?page=1&sort=false&filter=Updated Date"),
    headers: <String, String>{
      'Authorization': 'Bearer ${TokenStorage().getToken()}',
      'email': TokenStorage().getEmail()!,
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    final resData = json.decode(response.body);
    List<Patient> patients = (resData['patients'] as List)
        .map((patientJson) => Patient.fromJson(patientJson))
        .toList();
    return patients;
  } else {
    final errorData = json.decode(response.body);
    print(errorData['message']);
    errorMessage(errorData['message']);
    return null;
  }
}
