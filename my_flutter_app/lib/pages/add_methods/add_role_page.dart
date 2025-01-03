import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/MultipleChoiceSelector.dart';
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
  Map<int, String> options = {};
  List<int> selectedIndexes = [];

  void handleSelectionChanged(List<int> indexes) {
    setState(() {
      selectedIndexes = indexes;
    });
    print('Selected Indexes: $selectedIndexes');
  }

  @override
  void initState() {
    super.initState();
    fetchOptions();
  }

  Future<void> fetchOptions() async {
    try {
      final fetchedOptions = await getOptions('permissions');
      // Replace 'role' with the appropriate option name
      setState(() {
        options = fetchedOptions;
        final List<String> optionValues = options.values.toList();
      });
    } catch (e) {
      print('Error fetching options: $e');
    }
  }

  final TextEditingController roleNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: SingleChildScrollView(
          child: Container(
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
                        'Add a Role',
                        style: TextStyle(
                          fontSize: 35,
                          color: Color.fromARGB(255, 46, 74, 95),
                          fontWeight: FontWeight.bold,
                          //fontFamily: 'PlayfairDisplay',
                        ),
                      )),

                  MyInput2(
                    controller: roleNameController,
                    hintText: 'Role Name',
                    obscureText: false,
                    labelText: 'Role Name',
                  ),
                  SizedBox(height: 20),
                  MultipleChoiceSelector(
                    question: "Select Permissions",
                    options: options.values.toList(),
                    onSelectionChanged: handleSelectionChanged,
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 15, 10, 15),
                        child: MyButton2(
                          onTap: () {
                            // Handle button tap
                            print('Discard button tapped!');
                            Navigator.pushNamed(context, '/pageNav');
                          },
                          text: 'Discard',
                          backgroundColor: const Color.fromARGB(
                              255, 255, 4, 4), // Solid color
                          width: 150.0, // Custom width
                          height: 65.0, // Custom height
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(30.w, 15.h, 0.w, 15.h),
                        child: MyButton2(
                          onTap: () {
                            // Handle button tap
                            List<int> selectedKeys = selectedIndexes
                                .map((index) => options.keys.elementAt(index))
                                .toList();

                            addRole(roleNameController.text, selectedKeys);
                            Navigator.pushNamed(context, '/add_a_role');
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
              )),
        ));
  }
}
