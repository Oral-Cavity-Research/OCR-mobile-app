import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/my_button_2.dart';
import 'package:my_flutter_app/components/my_dropdown_bar.dart';

//import 'package:my_flutter_app/components/my_input.dart';
import 'package:my_flutter_app/components/my_input_2.dart';

class AddRole extends StatefulWidget {
  final void Function()? onTap;
  const AddRole({super.key, required this.onTap});

  @override
  State<AddRole> createState() => AddRolePageState();
}

class AddRolePageState extends State<AddRole> {
  final TextEditingController roleNameController = TextEditingController();
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
                  padding: const EdgeInsets.only(left: 0, top: 50),
                  child: const Image(
                    image: AssetImage('lib/images/icon1.png'),
                    width: 150,
                    height: 150,
                  ),
                ),

                //message
                Container(
                    padding: const EdgeInsets.only(left: 35),
                    child: const Text(
                      'Add a Role to,',
                      style: TextStyle(
                        fontSize: 35,
                        color: Color.fromARGB(255, 46, 74, 95),
                        fontWeight: FontWeight.bold,
                        //fontFamily: 'PlayfairDisplay',
                      ),
                    )),
                Container(
                    padding: const EdgeInsets.only(left: 35),
                    child: const Text(
                      'Role Id #12345,',
                      style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 46, 74, 95),
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'PlayfairDisplay',
                      ),
                    )),
                MyInput2(
                  controller: roleNameController,
                  hintText: 'Role Name',
                  obscureText: false,
                  labelText: 'Role Name',
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

                //email textfield

                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 10, 10),
                  child: MyButton2(
                    onTap: () {
                      // Handle button tap
                      print('Log in button tapped!');
                    },
                    text: 'Add an option  +',
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
                      padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                      child: MyButton2(
                        onTap: () {
                          // Handle button tap
                          print('Log in button tapped!');
                        },
                        text: 'Discard',
                        backgroundColor:
                            const Color.fromARGB(255, 255, 4, 4), // Solid color
                        width: 150.0, // Custom width
                        height: 65.0, // Custom height
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(55, 15, 30, 15),
                      child: MyButton2(
                        onTap: () {
                          // Handle button tap
                          print('Log in button tapped!');
                        },
                        text: 'Save',
                        backgroundColor: const Color.fromARGB(
                            255, 13, 62, 123), // Solid color
                        width: 150.0, // Custom width
                        height: 65.0, // Custom height
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(30, 20, 40, 5),
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
