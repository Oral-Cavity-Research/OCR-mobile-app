import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_flutter_app/pages/ReportUpload/reportUploadService.dart';

import '../../components/ResponsePopup.dart';
import '../../model/imageUploadModel.dart';
import '../../model/reportUploadModel.dart';

class ReportUploadForm extends StatefulWidget {
  final String teleconEntryId;
  const ReportUploadForm({Key? key,required this.teleconEntryId}) : super(key: key);

  @override
  _ReportUploadFormState createState() => _ReportUploadFormState();
}

class _ReportUploadFormState extends State<ReportUploadForm> {
  final _formKey = GlobalKey<FormState>();
  File? _report;

  final TextEditingController teleconEntryIdController = TextEditingController();
  final TextEditingController reportNameController = TextEditingController();

  Future<void> _pickReport() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );
    if (result != null) {
      setState(() {
        _report = File(result.files.single.path!);

        // Extract the file extension from the selected file
        String fileExtension = result.files.single.extension ?? '';

        // Get the current text from the form's report name field
        String currentReportName = reportNameController.text;

        // Set the report name with the current name plus the file extension
        if (fileExtension.isNotEmpty) {
          reportNameController.text = '$currentReportName.$fileExtension';
        }
      });
      print(_report);
    }
  }



  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate() && _report != null) {
      ReportUploadModel reportData = ReportUploadModel(
        teleconEntryId: widget.teleconEntryId,
        reportName: reportNameController.text
      );

      if (_report!.existsSync()) {
        print("File exists at path: ${_report?.path}");
      } else {
        print("File does not exist!");
      }

      final responseCode =
      await ReportUploadService().uploadReport(reportData, _report!);

      if (responseCode == 200) {
        print('report uploaded successfully');
        await responsePopup(context, "Success", "report uploaded successfully!");
        resetForm();
      } else {
        print('report upload failed. Status code: $responseCode');
        responsePopup(
            context, "Failure", "Error uploading file: $responseCode");
        resetForm();
      }
    } else {
      print('Form validation failed or report not selected');
      responsePopup(
          context, "Failure", "Form validation failed or report not selected");
      resetForm();
    }
  }

  void resetForm() {
    // Reset the form key state
    _formKey.currentState?.reset();

    // Clear text controllers
    teleconEntryIdController.clear();
    reportNameController.clear();

    // Clear the selected image and trigger UI update
    setState(() {
      _report = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'Report Upload Form',
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
                  controller: reportNameController,
                  decoration: const InputDecoration(
                    labelText: 'Report Name',
                    labelStyle: TextStyle(color: Color(0xFF002366)),
                  ),
                  style: const TextStyle(
                      fontFamily: 'Rubik', color: Color(0xFF002366)),
                  validator: (value) =>
                  value!.isEmpty ? 'This field is required' : null,
                ),
                const SizedBox(height: 20.0),
                _report == null
                    ? const Text(
                  'No report selected.',
                  style: TextStyle(color: Color(0xFF002366)),
                )
                    : Text(
                  'Selected report: ${_report!.path.split('/').last}',
                  style: TextStyle(color: Color(0xFF002366)),
                ),

                TextButton(
                  onPressed: _pickReport,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue[900],
                  ),
                  child: const Text('Pick report'),
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
