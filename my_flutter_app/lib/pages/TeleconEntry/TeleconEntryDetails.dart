import 'package:flutter/material.dart';
import '../ReportUpload/reportUploadScreen.dart';
import '../Reviews/AddReview.dart';
import '../imageUpload/ImageUploadScreen.dart';

class TeleconEntryDetails extends StatelessWidget {
  final Map<String, dynamic> data;
  final Map<String ,dynamic> clinician;

  TeleconEntryDetails({required this.data,required this.clinician});

  @override
  Widget build(BuildContext context) {
    final patient = data['patient'] ?? {};
    final List<dynamic> currentHabits = data['currentHabits'] ?? [];
    final List<dynamic> imageDetails = data['imageDetails'] ?? [];
    final List<dynamic> reportDetails = data['reportDetails'] ?? [];
    final List<dynamic> reviewers = data['reviewers'] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Telecon Entry Details',
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Patient Information
            Card(
              child: ListTile(
                title: Text('Patient Name'),
                subtitle: Text(patient['patientName'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Patient ID'),
                subtitle: Text(patient['patientId'] ?? 'N/A'),
              ),
            ),

            // Clinician Information
            Card(
              child: ListTile(
                title: Text('Clinician'),
                subtitle: Text(clinician['username'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Clinician Reg No'),
                subtitle: Text(clinician['regNo'] ?? 'N/A'),
              ),
            ),

            // Telecon Entry Information
            Card(
              child: ListTile(
                title: Text('Start Time'),
                subtitle: Text(data['startTime'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('End Time'),
                subtitle: Text(data['endTime'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Complaint'),
                subtitle: Text(data['complaint'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Findings'),
                subtitle: Text(data['findings'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Updated'),
                subtitle: Text(data['updated'] == true ? "Yes": "No"),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Checked'),
                subtitle: Text(data['checked'] == true ? "Yes": "No"),
              ),
            ),

            // Habits Information
            if (currentHabits.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Current Habits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...currentHabits.map<Widget>((habit) {
                return Card(
                  child: ListTile(
                    title: Text(habit['habit'] ?? 'N/A'),
                    subtitle: Text('Frequency: ${habit['frequency'] ?? 'N/A'}'),
                  ),
                );
              }).toList(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No habits available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],

            // Reviewers Information
            if (reviewers.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Reviewers', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...reviewers.map<Widget>((reviewer) {
                return Card(
                  child: ListTile(
                    title: Text(reviewer['username'] ?? 'N/A'),
                    subtitle: Text('Reg No: ${reviewer['reg_no'] ?? 'N/A'}'),
                  ),
                );
              }).toList(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No reviewers available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],

            // Image Details
            if (imageDetails.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Image Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...imageDetails.map<Widget>((image) {
                return Card(
                  child: ListTile(
                    title: Text(image['imageName'] ?? 'N/A'),
                    subtitle: Text('Location: ${image['location'] ?? 'N/A'}'),
                  ),
                );
              }).toList(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No images available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],

            // Report Details
            if (reportDetails.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Report Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...reportDetails.map<Widget>((report) {
                return Card(
                  child: ListTile(
                    title: Text(report['reportName'] ?? 'N/A'),
                    subtitle: Text('Created At: ${report['createdAt'] ?? 'N/A'}'),
                  ),
                );
              }).toList(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No reports available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],

            // Created At & Updated At
            Card(
              child: ListTile(
                title: Text('Created At'),
                subtitle: Text(data['createdAt'] ?? 'N/A'),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Updated At'),
                subtitle: Text(data['updatedAt'] ?? 'N/A'),
              ),
            ),


            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReviewForm(teleconId: data['id'])));
                  print("Upload Review button pressed");
                },
                icon: Icon(Icons.reviews_outlined,color :Colors.white),
                label: Text('Add a Review', style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
