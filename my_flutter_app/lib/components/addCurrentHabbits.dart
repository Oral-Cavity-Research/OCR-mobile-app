import 'package:flutter/material.dart';

class CurrentHabbitsForm extends StatefulWidget {
  final Function(Map<String, String>) onCurrentHabbitsAdded;

  CurrentHabbitsForm({required this.onCurrentHabbitsAdded});

  @override
  _CurrentHabbitsFormState createState() => _CurrentHabbitsFormState();
}

class _CurrentHabbitsFormState extends State<CurrentHabbitsForm> {
  bool showCurrentHabbitsFields = false;
  TextEditingController habitController = TextEditingController();
  TextEditingController frequencyController = TextEditingController();

  void addCurrentHabbits() {
    setState(() {
      showCurrentHabbitsFields = true; // Show the fields when button is pressed
    });
  }

  void saveCurrentHabbits() {
    if (habitController.text.isNotEmpty &&
        frequencyController.text.isNotEmpty ) {
      Map<String, String> newRiskFactor = {
        'habit': habitController.text,
        'frequency': frequencyController.text,
      };

      widget.onCurrentHabbitsAdded(newRiskFactor); // Use the callback to pass the new risk factor

      // Clear inputs after saving
      habitController.clear();
      frequencyController.clear();
      showCurrentHabbitsFields = false; // Hide fields after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Add Risk Factor Button
        ElevatedButton(
          onPressed: addCurrentHabbits,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[900], // Navy blue color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
            ),
          ),
          child: Text("Add Current Habbits",style: TextStyle(color: Colors.white)),

        ),

        // Label that appears after pressing "Add Risk Factor"
        if (showCurrentHabbitsFields)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              "Current Habbits",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),

        // Conditionally show the form fields
        if (showCurrentHabbitsFields) ...[
          TextField(
            controller: habitController,
            decoration: InputDecoration(labelText: "Habit"),
          ),
          TextField(
            controller: frequencyController,
            decoration: InputDecoration(labelText: "Frequency"),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: saveCurrentHabbits,
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
