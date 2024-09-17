import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/NotificationMessage.dart';
import 'package:my_flutter_app/components/error_message.dart';
import 'package:my_flutter_app/components/my_button.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';
import 'package:my_flutter_app/dto/VerifyResponse.dart';

class GoogleSignIN extends StatefulWidget {
  const GoogleSignIN({super.key});

  @override
  State<GoogleSignIN> createState() => _GoogleSignINState();
}

class _GoogleSignINState extends State<GoogleSignIN> {
  GoogleSignIn signIn = GoogleSignIn();

  late int statusCode;

  void googleSignOut() async {
    try {
      await signIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  Future<void> onLogin() async {
    print('Log in button tapped!');
    fetchEmail();

    if (statusCode == 200) {
      print("login successful");
      Navigator.of(context).pushNamed('/pageNav');
    } else {
      print('User not registered');
      errorMessage("User not registered");
    }
  }

  void fetchEmail() async {
    var user = await signIn.signIn();

    VerifyResponse response =
        await verify(user!.email, user!.photoUrl.toString());

    String? token = TokenStorage().getToken();
    // print('Token: $token');

    setState(() {
      statusCode = response.statusCode;
    });
  }

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
                  padding: EdgeInsets.fromLTRB(100.w, 75.h, 100.w, 0.h),
                  child: Image(
                    image: AssetImage('lib/images/icon1.png'),
                    width: 200.w,
                    height: 200.h,
                  ),
                ),

                //message
                Container(
                    padding: EdgeInsets.fromLTRB(150.w, 10.h, 150.w, 0.h),
                    child: const Text(
                      'User Login',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(120.w, 10.h, 120.w, 30.h),
                    child: const Text(
                      'Use this email to log in',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 79, 78, 78),
                      ),
                    )),

                //email textfield

                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 10.h),
                  child: MyButton(
                    onTap: onLogin,
                    // onTap: () async {
                    //   googleSignOut();
                    //   print("signing out");
                    // },
                    text: 'Log in with Google',
                    backgroundColor:
                        const Color.fromARGB(255, 34, 111, 205), // Solid color
                    width: 350.0, // Custom width
                    height: 45.0, // Custom height
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Not a member?",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary)),
                    GestureDetector(
                      onTap: () async {
                        var user = await signIn.signIn();
                        Navigator.of(context).pushNamed(
                          '/signin',
                          arguments: user!.email,
                        );
                      },
                      child: Text("Register Now",
                          style: TextStyle(
                              color: const Color.fromARGB(
                                  255, 53, 97, 148), // Solid color
                              //Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0.w, 320.h, 0.w, 50.h),
                        child: const Text(
                          '@mobile version of OASIS',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 89, 102, 121),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ),
                    ),
                  ],
                )

                //signin button
              ],
            )));
  }
}
