import 'dart:convert';
import 'package:flutter/material.dart';
import '../../URL.dart';

class shareEntriesScreen extends StatefulWidget {
  final String patientId;
  shareEntriesScreen({super.key,required this.patientId});
  @override
  _shareEntriesScreenState createState() => _shareEntriesScreenState();
}

class _shareEntriesScreenState extends State<shareEntriesScreen> {
  String _selectedSortOption = 'Updated Date';
  int _currentPage = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>> _entries = []; // List to store fetched entries

  final List<String> _sortOptions = ['Updated Date','Created Date'];

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
      final response = await shareTeleconEntries(_currentPage, _selectedSortOption,widget.patientId);
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
      appBar: AppBar(
        title: Text('Patient Telecon Entries',
          style: TextStyle(color: Colors.white),),
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
                List<dynamic> reviewers = entry['reviewers'] ?? [];
                return Card(
                  child: ListTile(
                    title: Text('Teleconsultation Id: ${entry['id'] ?? 'N/A'}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Complaint: ${entry['complaint']?? 'N/A'}'),
                        Text('Start Time: ${entry['startTime']?? 'N/A'}'),
                        Text('End Time: ${entry['endTime']?? 'N/A'}'),
                        Text('Findings: ${entry['findings']?? 'N/A'}'),
                        Text(
                          'Reviewer Names:',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10), // Adds spacing
                        reviewers.isNotEmpty
                            ? ListView.builder(
                          shrinkWrap: true, // Ensures it fits in the parent Column
                          physics: NeverScrollableScrollPhysics(), // Avoids conflicts with scroll
                          itemCount: reviewers.length,
                          itemBuilder: (context, index) {
                            var reviewer = reviewers[index];
                            return Text(
                              reviewer['username'] ?? 'N/A', // Safely access the username
                              style: TextStyle(fontSize: 16),
                            );
                          },
                        )
                            : Text(
                          'No reviewers available.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        Text('Created At: ${entry['createdAt'] ?? 'N/A'}'),
                        Text('Updated At: ${entry['updatedAt'] ?? 'N/A'}'),
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
