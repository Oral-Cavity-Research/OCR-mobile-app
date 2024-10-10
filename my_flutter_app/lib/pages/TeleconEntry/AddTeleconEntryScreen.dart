import 'package:flutter/material.dart';
import 'package:my_flutter_app/dto/HabbitDto.dart';
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
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();
  final TextEditingController findingController = TextEditingController();
  final List<Map<String, String>> Habbits = [];
  final List<TextEditingController> currentHabbitsController = [];

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

  }

  // Function to handle form submission
  Future<void> teleconFormSubmit(BuildContext context) async {
    if (_formKey.currentState!.validate() ) {
      TeleconEntryRequest entryData = TeleconEntryRequest(
          startTime: startTimeController.text,
          endTime: endTimeController.text,
          complaints: complaintController.text,
          finding: findingController.text,
          currentHabits: parseCurrentHabbits(),
      );

      // Call the TeleconService to create the entry
      final responseCode = await TeleconService()
          .createEntry(entryData,widget.patientId);

      if (responseCode == 200) {
        print('Teleconsultation Entry created successfully');
        await responsePopup(
            context, "Success", "Teleconsultation Entry created successfully!");
        resetForm();
      } else {
        print(
            'Teleconsultation Entry creating failed. Status code: $responseCode');
        responsePopup(
            context, "Failure",
            "Error creating Teleconsultation Entry: $responseCode");
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: Text(
          "Create new Teleconsultation Entry",
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
                // startTime
                TextFormField(
                  controller: startTimeController,
                  decoration: InputDecoration(labelText: "Start Time :"),
                  validator: (value) =>
                  value!.isEmpty ? "Start Time required" : null,
                ),
                TextFormField(
                  controller: endTimeController,
                  decoration: InputDecoration(labelText: "End Time :"),
                  validator: (value) =>
                  value!.isEmpty ? "End Time required" : null,
                ),
                TextFormField(
                  controller: complaintController,
                  decoration: InputDecoration(labelText: "Complaint :"),
                  validator: (value) =>
                  value!.isEmpty ? "Complaint is required" : null,
                ),
                TextFormField(
                  controller: findingController,
                  decoration: InputDecoration(labelText: "Findings :"),
                  validator: (value) =>
                  value!.isEmpty ? "Findings is required" : null,
                ),
                const SizedBox(height: 18.0),
                CurrentHabbitsForm(
                  onCurrentHabbitsAdded: (newCurrentHabbit) {
                    setState(() {
                      Habbits.add(newCurrentHabbit);
                    });
                  },
                ),
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
