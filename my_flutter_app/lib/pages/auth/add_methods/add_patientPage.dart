import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/my_button_2.dart';
import 'package:my_flutter_app/components/my_dropdaown_bar.dart';

//import 'package:my_flutter_app/components/my_input.dart';
import 'package:my_flutter_app/components/my_input_2.dart';

class AddPatientpage extends StatefulWidget {
  final void Function()? onTap;
  const AddPatientpage({super.key, required this.onTap});

  @override
  State<AddPatientpage> createState() => _addRolePageState();
}

class _addRolePageState extends State<AddPatientpage> {
  final TextEditingController RoleNameController = TextEditingController();
  String selectedItem = 'Access I';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 224, 235, 250),
                  Color.fromARGB(255, 152, 195, 235),
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo of the OASIS
                Container(
                  padding: const EdgeInsets.only(left: 0, top: 5),
                  child: const Image(
                    image: AssetImage('lib/images/icon1.png'),
                    width: 150,
                    height: 150,
                  ),
                ),

                //message
                Container(
                    padding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
                    child: const Text(
                      'Add a Role to,',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 46, 74, 95),
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'PlayfairDisplay',
                      ),
                    )),

                MyInput2(
                  controller: RoleNameController,
                  hintText: 'Enter name',
                  obscureText: false,
                  labelText: 'Name',
                ),
                MyInput2(
                  controller: RoleNameController,
                  hintText: 'Enter Age',
                  obscureText: false,
                  labelText: 'Age',
                ),
                MyDropdownInput(
                  labelText: 'Option I',
                  items: const [
                    'Access I',
                    'Access II',
                    'Access III',
                    'Access IV'
                  ],
                  selectedItem: selectedItem,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedItem = newValue!;
                    });
                  },
                ),

                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 159, 196, 230),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: 280,
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
                            fillColor: Colors
                                .white, // Background color of the TextField
                            hintText: "Add a Description",
                            hintStyle: TextStyle(color: Colors.grey),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                          ),
                          style: TextStyle(
                            fontSize: 16, // Adjust the font size
                          ),
                          maxLines: 10, // Adjust the number of lines
                          minLines: 1, // Adjust the number of lines
                        ),
                      ),
                    ),
                  ),
                ),

                //email textfield

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                  child: MyButton2(
                    onTap: () {
                      // Handle button tap
                      print('Log in button tapped!');
                    },
                    text: 'Add Photos  +',
                    backgroundColor:
                        const Color.fromARGB(255, 13, 62, 123), // Solid color
                    width: 200.0, // Custom width
                    height: 55.0, // Custom height
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                      child: MyButton2(
                        onTap: () {
                          // Handle button tap
                          print('Log in button tapped!');
                        },
                        text: 'Discard',
                        backgroundColor:
                            const Color.fromARGB(255, 255, 4, 4), // Solid color
                        width: 150.0, // Custom width
                        height: 60.0, // Custom height
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 0, 30, 0),
                      child: MyButton2(
                        onTap: () {
                          // Handle button tap
                          print('Log in button tapped!');
                        },
                        text: 'Save',
                        backgroundColor: const Color.fromARGB(
                            255, 13, 62, 123), // Solid color
                        width: 150.0, // Custom width
                        height: 60.0, // Custom height
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
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik',
                      ),
                    ),
                  ),
                ),

                //signin button
              ],
            )));
  }
}
