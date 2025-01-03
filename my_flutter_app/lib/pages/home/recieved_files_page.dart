import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:my_flutter_app/dto/ReviewerDetailsDto.dart';
import '../../URL.dart';

class ReceivedEntriesScreen extends StatefulWidget {
  const ReceivedEntriesScreen({super.key});

  @override
  _ReceivedEntriesScreenState createState() => _ReceivedEntriesScreenState();
}

class _ReceivedEntriesScreenState extends State<ReceivedEntriesScreen> {
  String _selectedSortOption = 'Assigned';
  int _currentPage = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>> _entries = []; // List to store fetched entries

  final List<String> _sortOptions = [
    'Assigned',
    'Unassigned',
    'Reviewed',
    'Unreviewed',
    'Newly Reviewed',
    'Created Date'
  ];

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
      final response =
      await receivedTeleconEntries(_currentPage, _selectedSortOption);
      if (response.statusCode == 200) {
        print(json.decode(response.body));
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _entries = List<Map<String, dynamic>>.from(
              jsonResponse); // Parse the entries into the state
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
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 171, 227, 255), // Sky blue
              Color.fromARGB(255, 91, 164, 209), // Light sky blue
              Colors.white, // White
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Sorting Dropdown
            Row(
              children: [
                const Text('Sort by: ', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 10),
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
            const SizedBox(height: 20),

            // List of Entries
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator()) // Show loading indicator
                  : _entries.isEmpty
                  ? const Center(child: Text('No entries found')) // Handle empty state
                  : ListView.builder(
                itemCount: _entries.length,
                itemBuilder: (context, index) {
                  final entry = _entries[index];
                  return Card(
                    child: ListTile(
                      title: Text(
                        'Teleconsultation Id: ${entry['id'] ?? 'N/A'}',
                        style: const TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                              'Patient Id: ${entry['patient']['patientId'] ?? 'N/A'}'),
                          Text(
                              'Patient Name: ${entry['patient']['patientName'] ?? 'N/A'}'),
                          const SizedBox(height: 10),
                          Text('Start Time: ${entry['startTime'] ?? 'N/A'}'),
                          Text('End Time: ${entry['endTime'] ?? 'N/A'}'),
                          Text('Updated: ${entry['updated'] ? 'Yes' : 'No'}'),
                          const SizedBox(height: 10),
                          const Text(
                            'Reviewer Names:',
                            style: TextStyle(fontSize: 15),
                          ),
                          entry['reviewers'].isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: entry['reviewers'].length,
                            itemBuilder: (context, reviewerIndex) {
                              var reviewer = entry['reviewers'][reviewerIndex];
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  reviewer['username'] ?? 'N/A',
                                  style: const TextStyle(fontSize: 15),
                                ),
                              );
                            },
                          )
                              : const Text(
                            'No reviewers available.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
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
                  onPressed: _currentPage > 1
                      ? () => _changePage(_currentPage - 1)
                      : null,
                  child: const Text('Previous'),
                ),
                const SizedBox(width: 20),
                Text('Page $_currentPage'),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _changePage(_currentPage + 1),
                  child: const Text('Next'),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
