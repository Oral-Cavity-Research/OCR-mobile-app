import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:my_flutter_app/dto/HabbitDto.dart';
import 'package:my_flutter_app/pages/TeleconEntry/TeleconEntryDetails.dart';
import '../../components/ResponsePopup.dart';
import '../../components/addCurrentHabbits.dart';
import '../../dto/TeleconEntryRequest.dart';
import 'TeleconService.dart';

class TeleconEntryForm extends StatefulWidget {
  final String patientId;

  TeleconEntryForm({required this.patientId});

  @override
  TeleconEntryFormState createState() => TeleconEntryFormState();
}

class TeleconEntryFormState extends State<TeleconEntryForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  //final TextEditingController startTimeController = TextEditingController();

  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController dayController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController findingController = TextEditingController();
  final List<Map<String, String>> Habbits = [];
  final List<TextEditingController> currentHabbitsController = [];

  String? selectedMonth;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  // Convert selected date and time to ISO format
  String formatDateTime({
    required String? selectedMonth,
    required TextEditingController dayController,
    required TextEditingController yearController,
    required TimeOfDay? selectedTime,
  }) {
    if (selectedMonth != null && dayController.text.isNotEmpty && yearController.text.isNotEmpty &&
        selectedTime != null) {
      // Get month index
      int monthIndex = months.indexOf(selectedMonth!) + 1;
      String formattedDate = '${yearController.text}-${monthIndex.toString().padLeft(2, '0')}-${dayController.text.padLeft(2, '0')}';

      // Format time
      final now = DateTime.now();
      final selectedDateTime = DateTime(now.year, now.month, now.day, selectedTime!.hour, selectedTime!.minute);
      String formattedTime = DateFormat('HH:mm:ss.SSS').format(selectedDateTime);

      return '$formattedDate"T"$formattedTime'.replaceAll('"', '');
    }
    return '';
  }

  // Show time picker
  Future<void> selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
          startTimeController.text = picked.format(context);
        } else {
          selectedEndTime = picked;
          endTimeController.text = picked.format(context);
        }
      });
    }
  }



  // Add a new habit controller
  void addHabbitsController(){
    final controller = TextEditingController();
    currentHabbitsController.add(controller);
    Habbits.add({"habit": "", "frequency": ""});
  }

  // Parse habits into a list of `HabbitDto`
  List<HabbitDto> parseCurrentHabbits(){
    return Habbits.map((Habbits){
      return HabbitDto(habit: Habbits['habit']!,
        frequency: Habbits['frequency']!,
      );
    }).toList();
  }

  // Reset the form fields and controllers
  void resetForm() {
    // Reset the form key state
    _formKey.currentState?.reset();

    // Clear text controllers
    startTimeController.clear();
    endTimeController.clear();
    complaintController.clear();
    findingController.clear();
    currentHabbitsController.clear();
    Habbits.clear();

  }

  // Function to handle form submission
  Future<void> teleconFormSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate() ) {
      String formattedStartTime = formatDateTime(
        selectedMonth: selectedMonth!,
        dayController: dayController,
        yearController: yearController,
        selectedTime: selectedStartTime!,
      );
      String formattedEndTime = formatDateTime(
        selectedMonth : selectedMonth!,
        dayController: dayController,
        yearController: yearController,
        selectedTime : selectedEndTime!,

      );
      TeleconEntryRequest entryData = TeleconEntryRequest(
          startTime: formattedStartTime,
          endTime: formattedEndTime,
          complaint: complaintController.text,
          findings: findingController.text,
          currentHabits: parseCurrentHabbits(),
      );

      // Call the TeleconService to create the entry
      final response = await TeleconService()
          .createEntry(entryData,widget.patientId);

      if (response.statusCode == 200) {
        print('Teleconsultation Entry created successfully');
        await responsePopup(
            context, "Success", "Teleconsultation Entry created successfully!");
        print(response.body);
        resetForm();

      } else {
        int statusCode = response.statusCode;
        print(
            'Teleconsultation Entry creating failed. Status code: $statusCode');
        responsePopup(
            context, "Failure",
            "Error creating Teleconsultation Entry: $statusCode");
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
                // Month, Day, Year
                Row(
                  children: [
                    // Month dropdown
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: selectedMonth,
                        hint: Text("Month"),
                        items: months.map((String month) {
                          return DropdownMenuItem<String>(
                            value: month,
                            child: Text(month),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedMonth = newValue;
                          });
                        },
                        decoration: InputDecoration(
                            labelText: 'Date of the entry:',
                          labelStyle: TextStyle(fontSize: 20.0)),
                        validator: (value) =>
                        value == null ? 'Month is required' : null,
                      ),
                    ),
                    SizedBox(width: 8),

                    // Day input field
                    Expanded(
                      child: TextFormField(
                        controller: dayController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(labelText: 'Day'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Day is required';
                          }
                          int? day = int.tryParse(value);
                          if (day == null || day < 1 || day > 31) {
                            return 'Invalid day';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 8),

                    // Year input field
                    Expanded(
                      child: TextFormField(
                        controller: yearController,
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        decoration: InputDecoration(labelText: 'Year'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Year is required';
                          }
                          int? year = int.tryParse(value);
                          if (year == null || year < 1900 || year > DateTime.now().year) {
                            return 'Invalid year';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Start Time picker
                TextFormField(
                  controller: startTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Start Time',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    await selectTime(context, true);
                  },
                  validator: (value) {
                    if (selectedStartTime == null) {
                      return 'Start Time is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: endTimeController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    suffixIcon: Icon(Icons.access_time),
                  ),
                  onTap: () async {
                    await selectTime(context, false);
                  },
                  validator: (value) {
                    if (selectedEndTime == null) {
                      return 'End Time is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                TextFormField(
                  controller: complaintController,
                  decoration: InputDecoration(labelText: "Complaint :"),
                  validator: (value) =>
                  value!.isEmpty ? "Complaint is required" :null,
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: findingController,
                  decoration: InputDecoration(labelText: "Findings :"),
                  validator: (value) =>
                  value!.isEmpty ? "Findings is required" : null,
                ),
                SizedBox(height: 20),
                const SizedBox(height: 18.0),
                CurrentHabbitsForm(
                  onCurrentHabbitsAdded: (newCurrentHabbit) {
                    setState(() {
                      Habbits.add(newCurrentHabbit);
                    });
                  },
                ),
                SizedBox(height: 20),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    teleconFormSubmit(context); // Wrap the function in a closure
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
