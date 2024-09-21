import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:my_flutter_app/Service/user_controler.dart';
import 'package:my_flutter_app/URL.dart';
import 'package:my_flutter_app/components/NotificationMessage.dart';
import 'package:my_flutter_app/components/error_message.dart';
import 'package:my_flutter_app/components/my_button_2.dart';
import 'package:my_flutter_app/dto/TokenStorage.dart';

class DoctorEditProfile extends StatefulWidget {
  const DoctorEditProfile({super.key});

  @override
  State<DoctorEditProfile> createState() => _DoctorEditProfileState();
}

class _DoctorEditProfileState extends State<DoctorEditProfile> {
  String new_name = TokenStorage().getUsername() ?? '';
  String new_hospital = TokenStorage().getHospital() ?? '';
  String new_regNo = TokenStorage().getRegNo() ?? '';
  String new_designation = TokenStorage().getDesignation() ?? '';
  String new_contactNo = TokenStorage().getContactNo() ?? '';
  bool new_availability = TokenStorage().getAvailability() ?? false;

  List<String> hospitalNames = [];

  bool validateInputs(String username, String phoneNumber, String hospital,
      String registration) {
    if (username.isEmpty) {
      errorMessage("Enter a valid username");
      return false;
    } else if (phoneNumber.isEmpty || phoneNumber.length < 10) {
      errorMessage("Enter a valid phone number");
      return false;
    } else if (hospital.isEmpty) {
      errorMessage("Enter a valid hospital name");
      return false;
    } else {
      return true;
    }
  }

  Future<void> save_changers(String new_name, String new_hospital,
      String new_contactNo, bool new_availability) async {
    if (validateInputs(new_name, new_contactNo, new_hospital, new_regNo)) {
      TokenStorage().setUsername(new_name);
      TokenStorage().setHospital(new_hospital);
      TokenStorage().setContactNo(new_contactNo);
      TokenStorage().setAvailability(new_availability);
      int ResponseCode = await updateUserSelf(
          new_name, new_hospital, new_contactNo, new_availability);
      if (ResponseCode == 200) {
        NotificationMessage('', "Profile updated successfully");
        Navigator.pushNamed(context, '/doctor_profile');
      } else {
        errorMessage('Profile update failed, try again later');
      }
    }
  }

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/doctor_profile');
          },
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Rubik',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
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
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: NetworkImage(TokenStorage().getImage() ??
                      'https://example.com/default_image.png'),
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit, color: Colors.black),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Center(
                                  child: const Text('Edit Profile Picture')),
                              content: const Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Center(
                                    child: Text(
                                        'To upload a new profile picture, '
                                        'you need to edit your profile picture via email.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: "Rubik",
                                        )),
                                  ),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(child: const Text('OK')),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                      subtitle: TextField(
                        controller: TextEditingController(
                          text: TokenStorage().getUsername() ?? '',
                        ),
                        onChanged: (value) {
                          new_name = value;
                        },
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
                      subtitle: DropdownButtonFormField<String>(
                        value: new_hospital,
                        items: hospitalNames
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            new_hospital = newValue!;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
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
                      subtitle: TextField(
                        controller: TextEditingController(
                          text: TokenStorage().getContactNo() ?? '',
                        ),
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          new_contactNo = value;
                        },
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    ListTile(
                      title: const Text(
                        'Availability:',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: "Rubik",
                        ),
                      ),
                      leading: Icon(Icons.schedule),
                      subtitle: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          return SwitchListTile(
                            title: Text(
                                new_availability
                                    ? 'Available'
                                    : 'Not Available',
                                style: const TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w400,
                                )),
                            value: new_availability,
                            activeColor: Color.fromARGB(255, 4, 87, 156),
                            inactiveTrackColor: Colors.red[50],
                            onChanged: (bool value) {
                              setState(() {
                                new_availability = value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(15.w, 40.h, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyButton2(
                            text: 'Save',
                            backgroundColor: Colors.blue[400]!,
                            onTap: () {
                              save_changers(new_name, new_hospital,
                                  new_contactNo, new_availability);
                              print('Changes saved');
                              // Save the changes
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
