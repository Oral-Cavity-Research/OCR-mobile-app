import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:my_flutter_app/components/my_button.dart';
import 'package:my_flutter_app/components/my_input.dart';

class SigninPage extends StatefulWidget {
  final void Function()? onTap;
  const SigninPage({super.key, required this.onTap});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //logo of the OASIS
            Container(
              padding: const EdgeInsets.only(left: 120),
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
                padding: const EdgeInsets.only(left: 20),
                child: const Text(
                  'This only sends a login request to the admin',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 79, 78, 78),
                  ),
                )),

            //email textfield
            my_input(
                controller: emailController,
                hintText: "Email",
                obscureText: false),
            //username textfield
            my_input(
                controller: usernameController,
                hintText: "UserName",
                obscureText: false),
            //registration textfield
            my_input(
                controller: registrationController,
                hintText: "SLMC Registration Number",
                obscureText: false),
            //phone number text field
            my_input(
                controller: phoneController,
                hintText: "Phone Number",
                obscureText: false),
            //hostpital textfield
            my_input(
                controller: hospitalController,
                hintText: "Hospital Name",
                obscureText: false),
            my_button(onTap: () {}, text: "Sign Up"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Not a member?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register Now",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold)),
                )
              ],
            )

            //signin button
          ],
        ));
  }
}
