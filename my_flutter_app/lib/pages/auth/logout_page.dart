import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/my_button.dart';

class LogoutPage extends StatefulWidget {
  final void Function()? onTap;
  const LogoutPage({super.key, required this.onTap});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  //textEditing controllers
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController registrationController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController hospitalController = TextEditingController();

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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //logo of the OASIS
                Container(
                  padding: const EdgeInsets.fromLTRB(120, 290, 0, 0),
                  child: const Image(
                    image: AssetImage('lib/images/icon1.png'),
                    width: 200,
                    height: 200,
                  ),
                ),

                //message
                Center(
                  child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 40, 0, 100),
                      child: const Text(
                        'Are you sure you want to log out?',
                        style: TextStyle(
                            fontSize: 25,
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      )),
                ),

                //email textfield

                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 10, 10),
                  child: MyButton(
                    onTap: () {
                      // Handle button tap
                      print('Log in button tapped!');
                    },
                    text: 'Log out',
                    backgroundColor:
                        const Color.fromARGB(255, 31, 114, 216), // Solid color
                    width: 350.0, // Custom width
                    height: 45.0, // Custom height
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                  child: MyButton(
                    onTap: () {
                      // Handle button tap
                      print('Log in button tapped!');
                    },
                    text: 'Cancel',
                    backgroundColor:
                        const Color.fromARGB(255, 1, 49, 107), // Solid color
                    width: 350.0, // Custom width
                    height: 45.0, // Custom height
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30, 0, 40, 5),
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
                ),
                //signin button
              ],
            )));
  }
}
