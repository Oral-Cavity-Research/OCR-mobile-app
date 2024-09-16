// image_upload_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../../model/annotationModel.dart';
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
      }
    });
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _image != null) {
      ImageUploadModel imageData = ImageUploadModel(
        teleconEntryId: teleconEntryIdController.text,
        imageName: imageNameController.text,
        location: locationController.text,
        clinicalDiagnosis: clinicalDiagnosisController.text,
        lesionsAppear: lesionsAppearController ?? false,
        predictedCat: predictedCatController.text,
      );

      final responseCode = await ImageUploadService().uploadImage(imageData, _image!);

      if (responseCode == 200) {
        print('Image uploaded successfully');
      } else {
        print('Image upload failed. Status code: $responseCode');
      }
    } else {
      print('Form validation failed or image not selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: teleconEntryIdController,
                decoration: const InputDecoration(labelText: 'Telecon Entry ID'),
                validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
              ),
              TextFormField(
                controller: imageNameController,
                decoration: const InputDecoration(labelText: 'Image Name'),
                validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
              ),
              TextFormField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
              ),
              TextFormField(
                controller: clinicalDiagnosisController,
                decoration: const InputDecoration(labelText: 'Clinical Diagnosis'),
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
                decoration: const InputDecoration(labelText: 'Lesions Appear'),
              ),
              TextFormField(
                controller: predictedCatController,
                decoration: const InputDecoration(labelText: 'Predicted Category'),
                validator: (value) =>
                value!.isEmpty ? 'This field is required' : null,
              ),
              TextFormField(
                controller: annotationsController,
                decoration: const InputDecoration(
                    labelText: 'Annotations (comma separated)'),
              ),
              const SizedBox(height: 10),
              _image == null
                  ? const Text('No image selected.')
                  : Image.file(_image!),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
