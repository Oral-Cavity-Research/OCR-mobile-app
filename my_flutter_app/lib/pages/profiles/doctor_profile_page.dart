import 'package:flutter/material.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white, // White
              Color.fromARGB(255, 95, 174, 213), // Sky blue
              Color.fromARGB(255, 124, 185, 223), // Light sky blue
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 40,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.15),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(
                          0, 3), // Offset to simulate southeast light source
                    ),
                  ],
                ),
                // child: Image.asset(
                //   'lib/images/icon1.png',
                //   height: 120,
                // ),
              ),
            ),
            //const SizedBox(height: 20),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 100,
                    backgroundImage: NetworkImage(TokenStorage().getImage() ??
                        'https://example.com/default_image.png'),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    // Wrapping ListView with Expanded
                    child: ListView(
                      children: [
                        ListTile(
                          title: const Text(
                            'Name:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.person),
                          subtitle: Text(
                            TokenStorage().getUsername() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Email:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.email),
                          subtitle: Text(
                            TokenStorage().getEmail() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Hospital:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.local_hospital),
                          subtitle: Text(
                            TokenStorage().getHospital() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Role:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.person_2_outlined),
                          subtitle: Text(
                            TokenStorage().getRole() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Registration Number:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.confirmation_number),
                          subtitle: Text(
                            TokenStorage().getRegNo() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Designation:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.design_services),
                          subtitle: Text(
                            TokenStorage().getDesignation() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        ListTile(
                          title: const Text(
                            'Contact No:',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Rubik",
                            ),
                          ),
                          leading: Icon(Icons.phone),
                          subtitle: Text(
                            TokenStorage().getContactNo() ?? '',
                            style: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w400,
                            ),
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
    );
  }
}
