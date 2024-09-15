import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  final TextEditingController locationController = TextEditingController();
  final TextEditingController clinicalDiagnosisController =
      TextEditingController();
  final TextEditingController lesionsAppearController = TextEditingController();
  final TextEditingController annotationsController = TextEditingController();
  final TextEditingController predictedCatController = TextEditingController();

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
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/api/user/upload/images/641060a61530810142e045de'),
      );

      if (_image != null) {
        request.files
            .add(await http.MultipartFile.fromPath('image', _image!.path));
      }

      request.fields['telecon_entry_id'] = teleconEntryIdController.text;
      request.fields['image_name'] =
          _image != null ? _image!.path.split('/').last : '';
      request.fields['location'] = locationController.text;
      request.fields['clinical_diagnosis'] = clinicalDiagnosisController.text;
      request.fields['lesions_appear'] = lesionsAppearController.text;
      request.fields['annotations'] =
          jsonEncode(annotationsController.text.split(','));
      request.fields['predicted_cat'] = predictedCatController.text;

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Submission successful');// Handle successful submission
      } else {
        print('Submission not successful');// Handle submission error
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
            color: Colors.white, // Text color set to white
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
                // Add logo at the top
                Center(
                  child: Image.asset(
                    'lib/images/icon1.png', // Ensure this path matches your asset path
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
                TextFormField(
                  controller: lesionsAppearController,
                  decoration: const InputDecoration(
                    labelText: 'Lesions Appear',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(fontFamily: 'Rubik', color: Colors.white),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
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
                TextFormField(
                  controller: annotationsController,
                  decoration: const InputDecoration(
                    labelText: 'Annotations (comma separated)',
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
