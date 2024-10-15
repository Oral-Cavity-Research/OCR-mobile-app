import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_flutter_app/components/doctor_notification.dart';
import 'package:my_flutter_app/components/menu_button.dart';

import '../../URL.dart';
//
// class RecievFiles extends StatefulWidget {
//   const RecievFiles({super.key});
//
//   @override
//   _RecievFilesState createState() => _RecievFilesState();
// }
//
// class _RecievFilesState extends State<RecievFiles>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;
//   bool isMenuOpen = false;
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _offsetAnimation = Tween<Offset>(
//       begin: const Offset(-1.0, 0.0),
//       end: const Offset(0.0, 0.0),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
//   }
//
//   void toggleMenu() {
//     setState(() {
//       if (isMenuOpen) {
//         _controller.reverse();
//       } else {
//         _controller.forward();
//       }
//       isMenuOpen = !isMenuOpen;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Gradient background
//           Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Color.fromARGB(255, 95, 174, 213), // Sky blue
//                   Color.fromARGB(255, 124, 185, 223), // Light sky blue
//                   Colors.white, // White
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//             ),
//           ),
//           GestureDetector(
//             onTap: () {
//               if (isMenuOpen) {
//                 toggleMenu();
//               }
//             },
//             child: Column(
//               children: [
//                 // Container(
//                 //   height: 100,
//                 //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                 //   decoration: const BoxDecoration(
//                 //     gradient: LinearGradient(
//                 //       colors: [
//                 //         Color.fromARGB(255, 87, 199, 255), // Dodger blue
//                 //         Color.fromARGB(255, 110, 133, 236), // Royal blue
//                 //       ],
//                 //       begin: Alignment.topLeft,
//                 //       end: Alignment.bottomRight,
//                 //     ),
//                 //     boxShadow: [
//                 //       BoxShadow(
//                 //         color: Colors.black26,
//                 //         blurRadius: 10,
//                 //         offset: Offset(0, 5),
//                 //       ),
//                 //     ],
//                 //   ),
//                 //   child: Padding(
//                 //     padding: const EdgeInsets.only(top: 30),
//                 //     child: Row(
//                 //       children: [
//                 //         const Spacer(),
//                 //         const Text(
//                 //           'Home',
//                 //           style: TextStyle(
//                 //             color: Colors.white,
//                 //             fontSize: 24,
//                 //             fontWeight: FontWeight.bold,
//                 //           ),
//                 //         ),
//                 //         const Spacer(),
//                 //         IconButton(
//                 //           icon: const Icon(Icons.arrow_forward,
//                 //               color: Colors.white),
//                 //           onPressed: () {},
//                 //         ),
//                 //       ],
//                 //     ),
//                 //   ),
//                 // ),
//                 Expanded(
//                   child: ListView(
//                     padding: const EdgeInsets.all(16),
//                     children: [
//                       // const Text(
//                       //   "RECIEVED FILES",
//                       //   style: TextStyle(
//                       //     fontFamily: 'Rubik',
//                       //     fontSize: 24,
//                       //     fontWeight: FontWeight.bold,
//                       //     color: Colors.white,
//                       //   ),
//                       // ),
//                       const SizedBox(height: 16),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                       buildDoctorNotification('DOC_ID: #12345',
//                           'Patient_id: 5454345', 'Date: 12/12/2022'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           if (isMenuOpen)
//             AnimatedOpacity(
//               opacity: isMenuOpen ? 1.0 : 0,
//               duration: const Duration(microseconds: 300),
//               child: GestureDetector(
//                 onTap: toggleMenu,
//                 child: Container(
//                   color: Colors.black.withOpacity(0.5),
//                   child: BackdropFilter(
//                     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                     child: Container(
//                       color: Colors.black.withOpacity(0.2),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           // SlideTransition(
//           //   position: _offsetAnimation,
//           //   child: Container(
//           //     width: 250,
//           //     padding: const EdgeInsets.only(top: 110),
//           //     decoration: const BoxDecoration(
//           //       color: Color.fromARGB(255, 152, 195, 235),
//           //       image: DecorationImage(
//           //         image: AssetImage('lib/images/whatsappBack.jpg'),
//           //         fit: BoxFit.cover,
//           //       ),
//           //       boxShadow: [
//           //         BoxShadow(
//           //           color: Colors.black26,
//           //           blurRadius: 10,
//           //           offset: Offset(0, 5),
//           //         ),
//           //       ],
//           //       borderRadius: BorderRadius.only(
//           //         topRight: Radius.circular(20),
//           //         bottomRight: Radius.circular(20),
//           //       ),
//           //     ),
//           //     // child: ListView(
//           //     //   padding: EdgeInsets.zero,
//           //     //   children: [
//           //     //     buildMenuButton(Icons.person, 'See Profile', toggleMenu),
//           //     //     buildMenuButton(Icons.add, 'Add a Patient', toggleMenu),
//           //     //     buildMenuButton(Icons.add, 'Add a Doctor', toggleMenu),
//           //     //     buildMenuButton(Icons.remove, 'Remove a Doctor', toggleMenu),
//           //     //     buildMenuButton(Icons.add, 'Add a Consultant', toggleMenu),
//           //     //     buildMenuButton(
//           //     //         Icons.remove, 'Remove a Consultant', toggleMenu),
//           //     //     buildMenuButton(Icons.add, 'Add a Role', toggleMenu),
//           //     //     buildMenuButton(Icons.logout, 'Log Out', toggleMenu),
//           //     //     buildMenuButton(Icons.info, 'About Us', toggleMenu),
//           //     //   ],
//           //     // ),
//           //   ),
//           // ),
//           // Positioned(
//           //   top: 30,
//           //   left: 16,
//           //   child: GestureDetector(
//           //     onTap: toggleMenu,
//           //     child: Container(
//           //       height: 65.0,
//           //       width: 65.0,
//           //       decoration: BoxDecoration(
//           //         shape: BoxShape.circle,
//           //         border: Border.all(
//           //           color: Colors.white,
//           //           width: 2.0,
//           //         ),
//           //         boxShadow: [
//           //           BoxShadow(
//           //             color: Colors.black.withOpacity(0.2),
//           //             spreadRadius: 1,
//           //             blurRadius: 6,
//           //             offset: const Offset(0, 4),
//           //           ),
//           //         ],
//           //       ),
//           //       child: ClipOval(
//           //         child: Material(
//           //           color: Colors.transparent,
//           //           child: InkWell(
//           //             splashColor: Colors.white24,
//           //             onTap: toggleMenu,
//           //             child: Image.asset(
//           //               'lib/images/icon1.png',
//           //               fit: BoxFit.cover,
//           //             ),
//           //           ),
//           //         ),
//           //       ),
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }
class ReceivedEntriesScreen extends StatefulWidget {
  const ReceivedEntriesScreen({super.key});
  @override
  _ReceivedEntriesScreenState createState() => _ReceivedEntriesScreenState();
}

class _ReceivedEntriesScreenState extends State<ReceivedEntriesScreen> {
  String _selectedSortOption = 'Created Date';
  int _currentPage = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>> _entries = []; // List to store fetched entries

  final List<String> _sortOptions = ['Assigned', 'Unassigned', 'Reviewed', 'Unreviewed', 'Newly Reviewed','Created Date'];

  @override
  void initState() {
    super.initState();
    _fetchEntries(); // Fetch initial data when screen is loaded
  }

  // Method to fetch entries from API
  Future<void> _fetchEntries() async {
    setState(() {
      _isLoading = true; // Show loading spinner while fetching data
    });

    try {
      final response = await receivedTeleconEntries(_currentPage, _selectedSortOption);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _entries = List<Map<String, dynamic>>.from(jsonResponse); // Parse the entries into the state
        });
      } else {
        throw Exception('Failed to load entries');
      }
    } catch (error) {
      print('Error fetching entries: $error');
    } finally {
      setState(() {
        _isLoading = false; // Hide loading spinner
      });
    }
  }

  // Method to handle pagination
  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
    _fetchEntries(); // Fetch new data for the selected page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Sorting Dropdown
          Row(
            children: [
              Text('Sort by: ', style: TextStyle(fontSize: 16)),
              SizedBox(width: 10),
              DropdownButton<String>(
                value: _selectedSortOption,
                items: _sortOptions.map((String option) {
                  return DropdownMenuItem<String>(
                    value: option,
                    child: Text(option),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSortOption = newValue!;
                    _currentPage = 1; // Reset to page 1 when sorting changes
                    _fetchEntries(); // Fetch sorted data
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),

          // List of Entries
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator()) // Show loading indicator
                : _entries.isEmpty
                ? Center(child: Text('No entries found')) // Handle empty state
                : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                return Card(
                  child: ListTile(
                    title: Text('Teleconsultation Id: ${entry['id'] ?? 'N/A'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Patient Id: ${entry['patient']['patientId'] ?? 'N/A'}'),
                        Text('Patient Name: ${entry['patient']['patientName'] ?? 'N/A'}'),
                        Text('Start Time: ${entry['startTime'] ?? 'N/A'}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Pagination Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
                child: Text('Previous'),
              ),
              SizedBox(width: 20),
              Text('Page $_currentPage'),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () => _changePage(_currentPage + 1),
                child: Text('Next'),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
