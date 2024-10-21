import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_flutter_app/components/menu_button.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';

class side_bar extends StatelessWidget {
  side_bar({super.key});

  void doctor_profile(BuildContext context) {
    Navigator.pushNamed(context, '/doctor_profile');
  }

  void about_us(BuildContext context) {
    Navigator.pushNamed(context, '/about_us');
  }

  void add_patient(BuildContext context) {
    Navigator.pushNamed(context, '/add_patient');
  }

  void add_role(BuildContext context) {
    Navigator.pushNamed(context, '/add_a_role');
  }

  // void allTeleconEntries(BuildContext context) {
  //   Navigator.pushNamed(context, '/receivedTeleconEntries');
  // }

  GoogleSignIn signIn = GoogleSignIn();

  void googleSignOut(BuildContext context) async {
    try {
      TokenStorage().clearUserData();
      await signIn.signOut();
      Navigator.pushNamed(context, '/login');
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'lib/images/whatsappBack.jpg'), // Replace with your image URL
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                TokenStorage().getUsername() ?? '',
                style: TextStyle(color: Colors.black)
                    .copyWith(fontWeight: FontWeight.bold)
                    .copyWith(fontSize: 20),
              ),
              accountEmail: Text(
                TokenStorage().getEmail() ?? '',
                style: TextStyle(color: Colors.black),
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(TokenStorage().getImage() ?? ''),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ73uBQOMwZ-78aKdnx7ndq_neLC4ddUhI4GLfdgsRiIQLhrOcnxBABocstk0LbVI0ne-I&usqp=CAU'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // ListTile(
            //   title: const Text('Home'),
            //   onTap: () {
            //     googleSignOut(context);
            //   },
            // ),
            buildMenuButton(
                Icons.person, 'See Profile', () => doctor_profile(context)),
            buildMenuButton(
                Icons.add, 'Add a Patient', () => add_patient(context)),
            buildMenuButton(Icons.add, 'Add a Role', () => add_role(context)),
            // buildMenuButton(
            //     Icons.remove, 'Remove a User', () => about_us(context)),
            buildMenuButton(Icons.info, 'About Us', () => about_us(context)),
            buildMenuButton(
                Icons.logout, 'Log Out', () => googleSignOut(context)),
            // buildMenuButton(
            //     Icons.medical_information_outlined, 'My TeleconEntries', () => allTeleconEntries(context)),
          ],
        ),
      ),
    );
  }
}
