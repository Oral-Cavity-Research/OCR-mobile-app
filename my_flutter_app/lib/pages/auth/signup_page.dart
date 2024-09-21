import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/NotificationMessage.dart';
import 'package:my_flutter_app/components/my_button.dart';
import 'package:my_flutter_app/components/my_input.dart';
import 'package:my_flutter_app/components/error_message.dart';

class SigninPage extends StatefulWidget {
  final String email;
  void Function()? onTap;
  SigninPage({super.key, onTap, required this.email});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  //textEditing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController designationController = TextEditingController();

  String? selectedHospital;

  late int statusCodeNew;

  bool validateInputs(String username, String phoneNumber, String hospital,
      String registration, String designation) {
    if (username.isEmpty) {
      errorMessage("Enter a valid username");
      return false;
    } else if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      errorMessage("Enter a valid phone number");
      return false;
    } else if (hospital.isEmpty) {
      errorMessage("Enter a valid hospital name");
      return false;
    } else if (registration.isEmpty) {
      errorMessage("Enter a valid registration number");
      return false;
    } else {
      return true;
    }
  }

  void onRegister() {
    // Handle button tap
    print('Log in button tapped!');
    print("Email: ${widget.email}\n");
    print("Username: ${usernameController.text}\n");
    print("Registration: ${registrationController.text}\n");
    print("Phone: ${phoneController.text}\n");
    print("Hospital: ${selectedHospital}\n");

    String username = usernameController.text;
    String phoneNumber = phoneController.text;
    String hospital = selectedHospital ?? "";
    String registration = registrationController.text;
    String designation = designationController.text;

    if (validateInputs(username, phoneNumber, hospital, registration, designation)) {
      fetchStatusCode(username, phoneNumber, hospital, registration, designation);
      if (statusCodeNew == 200) {
        print("Sign up successful");
        NotificationMessage(
            "Request is sent successfully. You will receive an Email on acceptance",
            "Thank you");
        // Redirect to home page
        Navigator.pushNamed(context, '/login');
      } else if (statusCodeNew == 401) {
        // Show error message
        errorMessage("User Email is already registered");
        navigator?.pop();
      } else {
        // Show error message
        errorMessage("Error in sending request");
        navigator?.pop();
      }
    }
  }

  // Function to fetch hospital list and update state
  void fetchStatusCode(username, phoneNumber, hospital, registration, designation) async {
    int status_code = await signup(
        widget.email, username, phoneNumber, hospital, registration, designation);
    setState(() {
      statusCodeNew = status_code;
    });
  }

  List<String> hospitalNames = [];

  @override
  void initState() {
    super.initState();
    fetchHospitalList(); // Fetch hospital list during initialization
  }

  // Function to fetch hospital list and update state
  void fetchHospitalList() async {
    List<String> fetchedHospitals = await hospitallist();
    setState(() {
      hospitalNames = fetchedHospitals;
    });
  }

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
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //logo of the OASIS
                    Container(
                      padding: EdgeInsets.only(left: 100.w),
                      child: const Image(
                        image: AssetImage('lib/images/icon1.png'),
                        width: 200,
                        height: 200,
                      ),
                    ),

                    //message
                    Container(
                        padding: const EdgeInsets.only(left: 20),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        )),
                    Container(
                        padding: EdgeInsets.only(left: 20.w),
                        child: const Text(
                          'This only sends a login request to the admin',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 79, 78, 78),
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    //email textfield
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.tertiary,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.primary,
                            )),
                            hintText: widget.email,
                            hintStyle: TextStyle(
                                color: Theme.of(context).colorScheme.primary),
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyInput(
                        controller: usernameController,
                        hintText: "UserName",
                        obscureText: false),
                    //registration textfield
                    MyInput(
                        controller: registrationController,
                        hintText: "SLMC Registration Number",
                        obscureText: false),
                    //phone number text field
                    MyInput(
                        keyboardType: TextInputType.number,
                        controller: phoneController,
                        hintText: "Phone Number",
                        obscureText: false),
                    MyInput(
                        controller: designationController,
                        hintText: "Designation",
                        obscureText: false),
                    //hospital dropdown
                    DropdownButton<String>(
                        value: selectedHospital,
                        hint: Text("Select Hospital"),
                        items: hospitalNames.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHospital = newValue;
                          });
                        }),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                      child: MyButton(
                        onTap: onRegister,
                        text: 'Register Now',
                        backgroundColor: const Color.fromARGB(
                            255, 31, 114, 216), // Solid color
                        width: 350.0.w, // Custom width
                        height: 45.0.h, // Custom height
                      ),
                    ),
                  ],
                ),
              )),
        ));
  }
}
