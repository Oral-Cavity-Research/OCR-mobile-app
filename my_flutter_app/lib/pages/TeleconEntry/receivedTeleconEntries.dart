import 'package:flutter/material.dart';

import '../../URL.dart';

class ReceivedEntryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> entries; // List of entries passed to the screen
  ReceivedEntryScreen({required this.entries});

  @override
  _ReceivedEntriesScreenState createState() => _ReceivedEntriesScreenState();
}

class _ReceivedEntriesScreenState extends State<ReceivedEntryScreen> {
  String _selectedSortOption = 'Created Date';
  int _currentPage = 1;

  // Sorting options for the dropdown
  final List<String> _sortOptions = ['Assigned', 'Unassigned', 'Reviewed', 'Unreviewed', 'Newly Reviewed', 'All'];

  // Method to handle pagination
  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Received Telecon Entries'),
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
        child: Column(
          children: [
            // Dropdown for sorting options
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
                      receivedTeleconEntries(_currentPage, _selectedSortOption);// Add sorting logic here
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.entries.length,
                itemBuilder: (context, index) {
                  final entry = widget.entries[index];
                  return Card(
                    child: ListTile(
                      title: Text('Telecon ID: ${entry['id'] ?? 'N/A'}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Patient Id: ${entry['patient'] ?? 'N/A'}'),
                          Text('complaint: ${entry['complaint'] ?? 'N/A'}'),
                          Text('Start Time: ${entry['startTime'] ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // Pagination buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
                  child: Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[500],
                  ),
                ),
                SizedBox(width: 10),
                Text('Page $_currentPage', style: TextStyle(fontSize: 16)),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _changePage(_currentPage + 1),
                  child: Text('Next'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
