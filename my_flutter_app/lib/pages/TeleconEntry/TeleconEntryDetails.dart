import 'package:flutter/material.dart';

import '../imageUpload/ImageUploadScreen.dart';

class TeleconEntryDetails extends StatelessWidget {
  final Map<String, dynamic> data;

  TeleconEntryDetails({required this.data});

  @override
  Widget build(BuildContext context) {
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
            Card(
              child: ListTile(
                title: Text('Start Time'),
                subtitle: Text(data['startTime'] ?? 'N/A'), // Handle null
              ),
            ),
            Card(
              child: ListTile(
                title: Text('End Time'),
                subtitle: Text(data['endTime'] ?? 'N/A'), // Handle null
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Complaint'),
                subtitle: Text(data['complaint'] ?? 'N/A'), // Handle null
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Findings'),
                subtitle: Text(data['findings'] ?? 'N/A'), // Handle null
              ),
            ),
            if (data['currentHabits'] != null && data['currentHabits'].isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('Current Habits', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              ...data['currentHabits'].map<Widget>((habit) {
                return Card(
                  child: ListTile(
                    title: Text(habit['habit'] ?? 'N/A'), // Handle null
                    subtitle: Text('Frequency: ${habit['frequency'] ?? 'N/A'}'), // Handle null
                  ),
                );
              }).toList(),
            ] else ...[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text('No habits available', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ],
            Card(
              child: ListTile(
                title: Text('Status'),
                subtitle: Text(data['status'] ?? 'N/A'), // Handle null
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Created At'),
                subtitle: Text(data['createdAt'] ?? 'N/A'), // Handle null
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Updated At'),
                subtitle: Text(data['updatedAt'] ?? 'N/A'), // Handle null
              ),

            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> ImageUploadForm(teleconEntryId: data['id'],)));
                  // Add image upload logic here
                  print("Upload Images button pressed");
                },
                icon: Icon(Icons.image),
                label: Text('Upload Images'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Button color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
