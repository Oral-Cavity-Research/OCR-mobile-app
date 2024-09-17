import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

import '../../dto/TokenStorage.dart';

class ImageUploadForm extends StatefulWidget {
  const ImageUploadForm({super.key});

  @override
  State<ImageUploadForm> createState() => _ImageUploadFormState();
}

class _ImageUploadFormState extends State<ImageUploadForm> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final picker = ImagePicker();

  final TextEditingController teleconEntryIdController =
  TextEditingController();
  final TextEditingController imageNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController clinicalDiagnosisController =
  TextEditingController();
  final TextEditingController predictedCatController = TextEditingController();

  bool? lesionsAppearController = false;

  @override
  void initState() {
    super.initState();
    print('ImageUploadForm page has been accessed');
  }

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_image == null) {
        print('No image selected.');
        return;
      }

      // Prepare the JSON data
      final jsonData = {
        'telecon_entry_id': teleconEntryIdController.text,
        'image_name': imageNameController.text,
        'location': locationController.text,
        'clinical_diagnosis': clinicalDiagnosisController.text,
        'lesions_appear': lesionsAppearController != null
            ? lesionsAppearController.toString()
            : 'false',
        'predicted_cat': predictedCatController.text,
      };

      // Create the multipart request
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/api/user/upload/images/646994b5dfd79c173bfba9c8'),
      );
      String? token = TokenStorage().getToken();
      String? email = TokenStorage().getEmail();

      request.headers['Authorization'] = 'Bearer $token';
      request.headers['email'] = '$email';
      request.headers['Content-Type'] = 'multipart/form-data';

      // Add the JSON data as a field
      request.fields['data'] = jsonEncode(jsonData);

      // Set the image file with the correct content type
      request.files.add(await http.MultipartFile.fromPath(
        'files',  // Ensure this is the correct field name expected by your backend
        _image!.path,
        contentType: MediaType('image', 'jpeg'), // or 'image/png'
      ));

      // Send the request
      final response = await request.send();
      final responseBody = await http.Response.fromStream(response);

      if (response.statusCode == 200) {
        print('Submission successful');
        print('Response Body: ${responseBody.body}');
      } else {
        print('Submission not successful');
        print('Response Body: ${responseBody.body}');
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Telecon Entry Form',
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 101, 174, 244),
              Color.fromARGB(255, 148, 192, 233),
              Color.fromARGB(255, 206, 219, 239),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Image.asset(
                    'lib/images/icon1.png',
                    height: 100,
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: teleconEntryIdController,
                  decoration: const InputDecoration(
                    labelText: 'Telecon Entry ID',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: imageNameController,
                  decoration: const InputDecoration(
                    labelText: 'Image Name',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: clinicalDiagnosisController,
                  decoration: const InputDecoration(
                    labelText: 'Clinical Diagnosis',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),

                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lesions Appear',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontFamily: 'Rubik',
                            color: Colors.white
                        ),
                      ),

                      DropdownButton<bool>(
                          value: lesionsAppearController,
                          hint: Text('This field is required'),

                          items:[true, false].map<DropdownMenuItem<bool>>((bool value) {
                            return DropdownMenuItem<bool>(
                              value: value,
                              child: Text(value ? 'True' : 'False'),
                            );
                          }).toList(),
                          onChanged: (bool? newValue) {
                            setState(() {
                              lesionsAppearController = newValue;
                            });
                          })
                    ]),
                TextFormField(
                  controller: predictedCatController,
                  decoration: const InputDecoration(
                    labelText: 'Predicted Category',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),
                const SizedBox(height: 20.0),
                _image == null
                    ? const Text(
                  'No image selected.',
                  style: TextStyle(color: Colors.white),
                )
                    : Image.file(_image!),
                TextButton(
                  onPressed: _pickImage,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900],
                  ),
                  child: const Text('Pick Image'),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

