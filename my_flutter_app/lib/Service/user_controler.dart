import 'package:http/http.dart' as http;
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';
import 'dart:convert';

import 'package:my_flutter_app/modals/DataProvider.dart';

// api/user/self/update
Future<int> updateUserSelf(String new_name, String new_hospital,
    String new_contactNo, bool new_availability) async {
  print('Updating user self');
  final response = await http.post(
    Uri.parse('${URL.BASE_URL}/user/self/update'),
    headers: <String, String>{
      'Authorization': 'Bearer ${TokenStorage().getToken()}',
      'email': TokenStorage().getEmail()!,
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "id": TokenStorage().getId() ?? '',
      "username": new_name,
      "hospital": new_hospital,
      "contactNo": new_contactNo,
      "availability": new_availability.toString(),
    }),
  );
  print(response.statusCode);
  print(response.body);
  return response.statusCode;
}
