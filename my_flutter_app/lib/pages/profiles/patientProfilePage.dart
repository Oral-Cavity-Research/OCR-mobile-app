import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/my_button_2.dart';

class PatientProfile extends StatefulWidget {
  final void Function()? onTap;
  const PatientProfile({super.key, required this.onTap});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final TextEditingController patientNameController = TextEditingController();
  String selectedItem = 'Access I';

  void _showForwardSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.67, // 2/3 of the screen
        minChildSize: 0.67,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return ForwardSheet(
            patientId: '123456',
            patientName: 'Sahan Perera',
            scrollController: scrollController,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 152, 195, 235),
              Color.fromARGB(255, 224, 235, 250),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 50),
                        child: const Image(
                          image: AssetImage('lib/images/icon1.png'),
                          width: 150,
                          height: 150,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: MyButton2(
                          onTap: () {
                            // Handle button tap
                            print('See Photos button tapped!');
                          },
                          text: 'See Photos',
                          backgroundColor:
                              Color.fromARGB(255, 55, 123, 206), // Solid color
                          width: 120.0, // Custom width
                          height: 60.0, // Custom height
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: MyButton2(
                          onTap: () {
                            // Handle button tap
                            print('Edit Photos button tapped!');
                          },
                          text: 'Edit Photos',
                          backgroundColor:
                              Color.fromARGB(255, 255, 88, 88), // Solid color
                          width: 120.0, // Custom width
                          height: 60.0, // Custom height
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70, right: 20),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 128, 175, 219),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      height: 280,
                      width: 270,
                      child: Container(
                        padding: const EdgeInsets.all(20.0),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Name: Sahan Perera',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 43, 54, 60),
                                fontFamily: 'Rubik',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'ID            : ABCD',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 43, 54, 60),
                                fontFamily: 'Rubik',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'District   : Kandy',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 43, 54, 60),
                                fontFamily: 'Rubik',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Province : Central',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 43, 54, 60),
                                fontFamily: 'Rubik',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Age        : 34',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 43, 54, 60),
                                fontFamily: 'Rubik',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
              child: const Text(
                'Status',
                style: TextStyle(
                  fontSize: 30,
                  color: Color.fromARGB(255, 46, 74, 95),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 159, 196, 230),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 450,
                  width: 390,
                  child: Container(
                    padding: const EdgeInsets.all(20.0),
                    width: 20,
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 0, 179, 255)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 255, 255, 255)),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Enter status",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20.0),
                      ),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 20,
                      minLines: 1,
                    ),
                  ),
                ),
              ),
            ),
            const Expanded(
              child: SizedBox(),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 20, 0),
                  child: MyButton2(
                    onTap: () {
                      print('Edit Status button tapped!');
                    },
                    text: 'Edit Status',
                    backgroundColor: Color.fromARGB(255, 255, 88, 88),
                    width: 120.0,
                    height: 60.0,
                  ),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("See report",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: MyButton2(
                    onTap: () {
                      _showForwardSheet(context);
                    },
                    text: 'Forward',
                    backgroundColor: Color.fromARGB(255, 90, 160, 225),
                    width: 120.0,
                    height: 60.0,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 40, 0),
                child: const Text(
                  '@mobile version of OASIS',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color.fromARGB(255, 52, 54, 57),
                    fontFamily: 'Rubik',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForwardSheet extends StatelessWidget {
  final String patientId;
  final String patientName;
  final ScrollController scrollController;

  const ForwardSheet({
    Key? key,
    required this.patientId,
    required this.patientName,
    required this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        gradient: LinearGradient(
          colors: [
            Color(0xFF87CEFA), // Light sky blue
            Colors.white, // White
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share With,',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color.fromARGB(255, 73, 113, 147)),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 73, 113, 147),
                ),
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Color.fromARGB(255, 73, 113, 147).withOpacity(0.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 73, 113, 147).withOpacity(
                          0.5)), // Color of the border when focused
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                      color:
                          Colors.white), // Color of the border when not focused
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10.0),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Suggested,',
              style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Rubik',
                  color: Color.fromARGB(255, 73, 113, 147)),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _circularImage('lib/images/sampleDoc.jpg'),
                _circularImage('lib/images/sampleDoc.jpg'),
                _circularImage('lib/images/sampleDoc.jpg'),
                _circularImage('lib/images/sampleDoc.jpg'),
                _circularImage('lib/images/sampleDoc.jpg'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Patient: #12345',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Rubik',
                  color: Color.fromARGB(255, 73, 113, 147)),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 0, 179, 255)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 255, 255, 255)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                filled: true,
                fillColor: Colors.white, // Background color of the TextField
                hintText: "Add a note",
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
              ),
              style: TextStyle(
                fontSize: 16, // Adjust the font size
              ),
              maxLines: 10, // Adjust the number of lines
              minLines: 1, // Adjust the number of lines
            ),
            SizedBox(height: 20),
            Text(
              'Warning!',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  //  fontFamily: 'Rubik',
                  color: Color.fromARGB(255, 255, 0, 0)),
            ),
            Text(
              'This data only includes patient’s report details only!. Anyother personal details cannor forward through this method!',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Rubik',
                  color: Color.fromARGB(255, 255, 0, 0)),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 130),
              child: Row(
                children: [
                  Center(
                    child: MyButton2(
                      onTap: () {
                        Navigator.pop(context); // Close the bottom sheet
                      },
                      text: 'Send',
                      backgroundColor: Color.fromARGB(255, 90, 160, 225),
                      width: 120.0,
                      height: 60.0,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(
                    Icons.send, // Replace with your desired icon
                    size: 30.0, // Adjust the size as needed
                    color: Color.fromARGB(
                        255, 56, 122, 183), // Change the color if necessary
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _circularImage(String imagePath) {
  return ClipOval(
    child: Image.asset(
      imagePath,
      width: 60, // You can adjust the size
      height: 60, // You can adjust the size
      fit: BoxFit.cover,
    ),
  );
}
