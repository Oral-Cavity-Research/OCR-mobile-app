import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/error_message.dart';
import 'dart:convert';

import 'package:my_flutter_app/dto/TokenStorage.dart';
import 'package:my_flutter_app/modals/Patient.dart';

import 'package:provider/provider.dart';

// class URL {
//   static const String BASE_URL = "http://10.0.2.2:8080/api";
// }

class DataProvider extends ChangeNotifier {
  // Move the line inside a method or constructor where the context is available

  bool loading = false;
  bool noMore = false;
  List data = [];

  Future<List<Patient>?> getData(
    String search,
    String filter,
    String sort,
    Patient patient,
  ) async {
    setLoading(true);
    setNoMore(false);

    try {
      print("bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
      print(TokenStorage().getToken());
      print(TokenStorage().getEmail()!);

      final response = await http.get(
        Uri.parse(
            '${URL.BASE_URL}/user/patient/get?page=1&search=$search&filter=$filter&sort=$sort'),
        headers: {
          'Authorization': 'Bearer ${TokenStorage().getToken()}',
          'email': TokenStorage().getEmail()!,
        },
      );
      print(response.statusCode);
      if (response.statusCode == 200) {
        final resData = json.decode(response.body);
        if (resData['patients']?.length < 20) setNoMore(true);

        List<Patient> patients = (resData['patients'] as List)
            .map((patientJson) => Patient.fromJson(patientJson))
            .toList();
        return patients;
      } else {
        final errorData = json.decode(response.body);
        errorMessage(errorData['message']);
        return null;
      }
    } catch (err) {
      errorMessage(err.toString());
      return null;
    } finally {
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  void setNoMore(bool value) {
    noMore = value;
    notifyListeners();
  }

  void setData(List value) {
    data = value;
    notifyListeners();
  }
}
