import 'package:flutter/material.dart';

class RiskFactorForm extends StatefulWidget {
  final Function(Map<String, String>) onRiskFactorAdded;

  RiskFactorForm({required this.onRiskFactorAdded});

  @override
  _RiskFactorFormState createState() => _RiskFactorFormState();
}

class _RiskFactorFormState extends State<RiskFactorForm> {
  bool showRiskFactorFields = false;
  TextEditingController habitController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();
  TextEditingController durationController = TextEditingController();

  void addRiskFactor() {
    setState(() {
      showRiskFactorFields = true; // Show the fields when button is pressed
    });
  }

  void saveRiskFactor() {
    if (habitController.text.isNotEmpty &&
        frequencyController.text.isNotEmpty &&
        durationController.text.isNotEmpty) {
      Map<String, String> newRiskFactor = {
        'habit': habitController.text,
        'frequency': frequencyController.text,
        'duration': durationController.text,
      };

      widget.onRiskFactorAdded(newRiskFactor); // Use the callback to pass the new risk factor

      // Clear inputs after saving
      habitController.clear();
      frequencyController.clear();
      durationController.clear();
      showRiskFactorFields = false; // Hide fields after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add Risk Factor Button
        ElevatedButton(
          onPressed: addRiskFactor,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900], // Navy blue color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
            ),
          ),
          child: Text("Add Risk Factor",style: TextStyle(color: Colors.white)),

        ),

        // Label that appears after pressing "Add Risk Factor"
        if (showRiskFactorFields)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Risk Factors",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),

        // Conditionally show the form fields
        if (showRiskFactorFields) ...[
          TextField(
            controller: habitController,
            decoration: InputDecoration(labelText: "Habit"),
          ),
          TextField(
            controller: frequencyController,
            decoration: InputDecoration(labelText: "Frequency"),
          ),
          TextField(
            controller: durationController,
            decoration: InputDecoration(labelText: "Duration"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: saveRiskFactor,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[900], // Navy blue color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
              ),
            ),
            child: Text("Save Risk Factor",style: TextStyle(color: Colors.white)),
          ),
        ],
      ],
    );
  }
}
