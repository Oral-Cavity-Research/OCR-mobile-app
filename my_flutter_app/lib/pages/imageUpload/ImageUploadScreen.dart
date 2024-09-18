import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/ResponsePopup.dart';
import '../../model/imageUploadModel.dart';
import 'ImageUploadService.dart';

class ImageUploadForm extends StatefulWidget {
  const ImageUploadForm({Key? key}) : super(key: key);

  @override
  _ImageUploadFormState createState() => _ImageUploadFormState();
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
  final TextEditingController annotationsController = TextEditingController();
  final TextEditingController predictedCatController = TextEditingController();

  bool? lesionsAppearController = false;

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      }
    });
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate() && _image != null) {
      ImageUploadModel imageData = ImageUploadModel(
        teleconEntryId: teleconEntryIdController.text,
        imageName: imageNameController.text,
        location: locationController.text,
        clinicalDiagnosis: clinicalDiagnosisController.text,
        lesionsAppear: lesionsAppearController ?? false,
        predictedCat: predictedCatController.text,
      );

      if (_image!.existsSync()) {
        print("File exists at path: ${_image?.path}");
      } else {
        print("File does not exist!");
      }

      final responseCode =
          await ImageUploadService().uploadImage(imageData, _image!);

      if (responseCode == 200) {
        print('Image uploaded successfully');
        await responsePopup(context, "Success", "Image uploaded successfully!");
        resetForm();
      } else {
        print('Image upload failed. Status code: $responseCode');
        responsePopup(
            context, "Failure", "Error uploading file: $responseCode");
        resetForm();
      }
    } else {
      print('Form validation failed or image not selected');
      responsePopup(
          context, "Failure", "Form validation failed or image not selected");
      resetForm();
    }
  }

  void resetForm() {
    // Reset the form key state
    _formKey.currentState?.reset();

    // Clear text controllers
    teleconEntryIdController.clear();
    imageNameController.clear();
    locationController.clear();
    clinicalDiagnosisController.clear();
    annotationsController.clear();
    predictedCatController.clear();

    // Reset other fields
    lesionsAppearController = false;

    // Clear the selected image and trigger UI update
    setState(() {
      _image = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Image Upload Form',
          style: TextStyle(
            fontFamily: 'Rubik',
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[900],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 59, 158, 215), // Dodger blue
                Color.fromARGB(255, 122, 188, 245), // Royal blue
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(255, 95, 174, 213), // Sky blue
              Color.fromARGB(255, 124, 185, 223), // Light sky blue
              Colors.white, // White
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
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: imageNameController,
                  decoration: const InputDecoration(
                    labelText: 'Image Name',
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
                TextFormField(
                  controller: clinicalDiagnosisController,
                  decoration: const InputDecoration(
                    labelText: 'Clinical Diagnosis',
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<bool>(
                    value: lesionsAppearController,
                    items: [true, false].map((bool value) {
                      return DropdownMenuItem<bool>(
                        value: value,
                        child: Text(value ? 'True' : 'False'),
                      );
                    }).toList(),
                    onChanged: (bool? newValue) {
                      setState(() {
                        lesionsAppearController = newValue;
                      });
                    },
                    decoration:
                        const InputDecoration(labelText: 'Lesions Appear'),
                    style: const TextStyle(
                        fontFamily: 'Rubik', color: Color(0xFF002366))),
                TextFormField(
                  controller: predictedCatController,
                  decoration: const InputDecoration(
                    labelText: 'Predicted Category',
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                      value!.isEmpty ? 'This field is required' : null,
                ),
                const SizedBox(height: 20.0),
                _image == null
                    ? const Text(
                        'No image selected.',
                        style: TextStyle(color: Color(0xFF002366)),
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
                  onPressed: () {
                    _submitForm(context); // Wrap the function in a closure
                  },
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
