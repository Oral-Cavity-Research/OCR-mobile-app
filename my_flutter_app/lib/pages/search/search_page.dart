// lib/pages/search/searchPage.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_flutter_app/components/patientCard.dart';
import 'package:my_flutter_app/modals/DataProvider.dart';
import 'package:my_flutter_app/modals/Patient.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _isChecked = "False";
  String _Filter = 'Name';
  int _selectedIndex = 0;
  String _Search = '';
  List<Patient> patientsCards = [];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      // Handle navigation or other actions here based on the tapped index
    });
  }

  @override
  Widget build(BuildContext context) {
    Patient patient = Provider.of<Patient>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 171, 227, 255), // Sky blue
                Color.fromARGB(255, 91, 164, 209), // Light sky blue
                Colors.white, // White
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search using patient number',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                        keyboardType: TextInputType.text,
                        onChanged: (value) {
                          // Fetch patient data based on input
                          DataProvider dataProvider = DataProvider();
                          dataProvider
                              .getData(value, _Filter, _isChecked, patient)
                              .then((patients) {
                            if (patients != null) {
                              // Update the state with the fetched patients list
                              setState(() {
                                _Search = value;
                                patientsCards = patients;
                              });
                            }
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'SEARCH OPTIONS',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            title: const Text('Sort:'),
                            value: _isChecked == "True",
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _isChecked = "True";
                                } else {
                                  _isChecked = "False";
                                }
                              });
                              DataProvider dataProvider = DataProvider();
                              dataProvider
                                  .getData(
                                      _Search, _Filter, _isChecked, patient)
                                  .then((patients) {
                                if (patients != null) {
                                  // Update the state with the fetched patients list
                                  setState(() {
                                    patientsCards = patients;
                                  });
                                }
                              });
                            },
                          ),
                          DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              labelText: 'Filter:',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                            ),
                            items: <String>[
                              'Name',
                              'Age',
                              'Gender',
                              'Created Date',
                              'Updated Date'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _Filter = value!;
                              });

                              DataProvider dataProvider = DataProvider();
                              dataProvider
                                  .getData(
                                      _Search, _Filter, _isChecked, patient)
                                  .then((patients) {
                                if (patients != null) {
                                  // Update the state with the fetched patients list
                                  setState(() {
                                    patientsCards = patients;
                                  });
                                }
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            child: Container(
                              height: 500.0, // Adjust the height as needed
                              child: ListView.builder(
                                itemCount: patientsCards.length,
                                itemBuilder: (context, index) {
                                  final patientDetails = patientsCards[index];
                                  return patientCard(
                                    name: patientDetails.getPatientName,
                                    id: patientDetails
                                        .getPatientId, // Safely handled
                                    dob: patientDetails.getDob,
                                    gender: patientDetails.getGender,
                                  );
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Image.asset(
                              'lib/images/icon1.png',
                              height: 80,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBarItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: _selectedIndex == index ? Colors.blue : Colors.grey),
          Text(label,
              style: TextStyle(
                  color: _selectedIndex == index ? Colors.blue : Colors.grey)),
        ],
      ),
    );
  }
}
