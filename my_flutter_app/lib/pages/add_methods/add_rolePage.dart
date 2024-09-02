import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_flutter_app/components/my_button_2.dart';
import 'package:my_flutter_app/components/my_dropdaown_bar.dart';

//import 'package:my_flutter_app/components/my_input.dart';
import 'package:my_flutter_app/components/my_input_2.dart';

class addRole extends StatefulWidget {
  final void Function()? onTap;
  const addRole({super.key, required this.onTap});

  @override
  State<addRole> createState() => _addRolePageState();
}

class _addRolePageState extends State<addRole> {
  final TextEditingController RoleNameController = TextEditingController();
  String selectedItem = 'Access I';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
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
                    padding: EdgeInsets.only(left: 0.w, top: 3.h),
                    child: const Image(
                      image: AssetImage('lib/images/icon1.png'),
                      width: 150,
                      height: 150,
                    ),
                  ),

                  //message
                  Container(
                      padding: EdgeInsets.only(left: 35.w),
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
                      padding: EdgeInsets.only(left: 35.w),
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
                    controller: RoleNameController,
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
                    padding: EdgeInsets.fromLTRB(20.w, 5.h, 10.w, 1.h),
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
                  // const Expanded(
                  //   child: SizedBox(),
                  // ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20.w, 5.h, 2.w, 15.h),
                        child: MyButton2(
                          onTap: () {
                            // Handle button tap
                            print('Log in button tapped!');
                          },
                          text: 'Discard',
                          backgroundColor: const Color.fromARGB(
                              255, 255, 4, 4), // Solid color
                          width: 150.0, // Custom width
                          height: 65.0, // Custom height
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.w, 5.h, 20.w, 5.h),
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
                      padding: EdgeInsets.fromLTRB(30.w, 40.h, 40.w, 20.h),
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
              )),
        ));
  }
}

void main() {
  runApp(MaterialApp(
    home: const addRole(onTap: null),
  ));
}
