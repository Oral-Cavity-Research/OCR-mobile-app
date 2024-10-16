import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/dto/HabbitDto.dart';
import 'package:my_flutter_app/pages/Reviews/ReviewService.dart';
import 'package:my_flutter_app/pages/TeleconEntry/TeleconEntryDetails.dart';
import '../../../components/ResponsePopup.dart';
import '../../../components/addCurrentHabbits.dart';
import '../../../dto/TeleconEntryRequest.dart';
import '../../URL.dart';
import '../../dto/ReviewRequestDto.dart';

class ReviewForm extends StatefulWidget {
  final String teleconId;

  ReviewForm({required this.teleconId});

  @override
  ReviewFormState createState() => ReviewFormState();
}

class ReviewFormState extends State<ReviewForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController provisionalDiagnosisController = TextEditingController();
  final TextEditingController managementSuggestionsController = TextEditingController();
  final TextEditingController referralSuggestionsController = TextEditingController();
  final TextEditingController otherCommentsController = TextEditingController();

  // Reset the form fields and controllers
  void resetForm() {
    // Reset the form key state
    _formKey.currentState?.reset();

    // Clear text controllers
    provisionalDiagnosisController.clear();
    managementSuggestionsController.clear();
    referralSuggestionsController.clear();
    otherCommentsController.clear();
  }

  // Function to handle form submission
  Future<void> reviewFormSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      ReviewRequest entryData = ReviewRequest(
        provisionalDiagnosis: provisionalDiagnosisController.text,
        managementSuggestions: managementSuggestionsController.text,
        referralSuggestions: referralSuggestionsController.text,
        otherComments: otherCommentsController.text,
      );

      final response = await ReviewService().createRequest(entryData, widget.teleconId);

      if (response.statusCode == 200) {
        print('Review created successfully');
        await responsePopup(
          context,
          "Success",
          "Review created successfully!",
        );
        resetForm();
      } else {
        int statusCode = response.statusCode;
        print('Review creating failed. Status code: $statusCode');
        await responsePopup(
          context,
          "Failure",
          "Error creating Review: $statusCode",
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Create Telecon Entry",
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 59, 158, 215), // Dodger blue
                Color.fromARGB(255, 122, 188, 245), // Royal blue
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 95, 174, 213), // Sky blue
              Color.fromARGB(255, 124, 185, 223), // Light sky blue
              Colors.white, // White
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Provisional Diagnosis
                TextFormField(
                  controller: provisionalDiagnosisController,
                  decoration: InputDecoration(labelText: "Provisional Diagnosis:"),
                  validator: (value) => value!.isEmpty ? "Provisional Diagnosis is required" : null,
                ),
                SizedBox(height: 20),
                // Management Suggestions
                TextFormField(
                  controller: managementSuggestionsController,
                  decoration: InputDecoration(labelText: "Management Suggestions:"),
                  validator: (value) => value!.isEmpty ? "Management Suggestions are required" : null,
                ),
                SizedBox(height: 20),
                // Referral Suggestions
                TextFormField(
                  controller: referralSuggestionsController,
                  decoration: InputDecoration(labelText: "Referral Suggestions:"),
                  validator: (value) => value!.isEmpty ? "Referral Suggestions are required" : null,
                ),
                SizedBox(height: 20),
                // Other Comments
                TextFormField(
                  controller: otherCommentsController,
                  decoration: InputDecoration(labelText: "Other Comments:"),
                  validator: (value) => value!.isEmpty ? "Other Comments are required" : null,
                ),
                SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    reviewFormSubmit(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
