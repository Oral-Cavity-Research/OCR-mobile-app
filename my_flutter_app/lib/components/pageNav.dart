import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_flutter_app/components/drawyer.dart';
import 'package:my_flutter_app/pages/home/home_page_1.dart';
import 'package:my_flutter_app/pages/home/recieved_files_page.dart';
import 'package:my_flutter_app/pages/home/sent_files_page.dart';
import 'package:my_flutter_app/pages/search/search_page.dart';

class Pagenav extends StatefulWidget {
  const Pagenav({super.key});

  @override
  State<Pagenav> createState() => _PagenavState();
}

class _PagenavState extends State<Pagenav> {
  int _selectedIndex = 0;
  String pageName = 'Home';
  List<Widget> widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    SentFiles(),
    RecievFiles(),
  ];

  String getPageName(int index) {
    switch (index) {
      case 0:
        return 'Home';
      case 1:
        return 'Search';
      case 2:
        return 'Sent TeleCon';
      case 3:
        return 'Recieved TeleCon';
      default:
        return 'Home';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('Index: $_selectedIndex');
      pageName = getPageName(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: side_bar(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pageName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontFamily: 'Rubik',
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 59, 158, 215), // Dodger blue
                Color.fromARGB(255, 122, 188, 245), // Royal blue
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(66, 255, 255, 255),
                blurRadius: 10,
                offset: Offset(0, 5),
              ),
            ],
          ),
        ),
      ),
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: CurvedNavigationBar(
        items: const <Widget>[
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.send),
          Icon(Icons.call_received),
        ],
        index: _selectedIndex,
        height: 50,
        color: const Color.fromARGB(255, 142, 204, 255),
        buttonBackgroundColor: const Color.fromARGB(255, 165, 214, 255),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: _onItemTapped,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Pagenav(),
  ));
}
