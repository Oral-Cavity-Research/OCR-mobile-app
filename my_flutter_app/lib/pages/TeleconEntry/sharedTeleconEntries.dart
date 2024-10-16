import 'dart:convert';

import 'package:flutter/material.dart';

import '../../URL.dart';
import '../../dto/ReviewerDetailsDto.dart';
import 'TeleconEntryDetails.dart';

class SharedEntriesScreen extends StatefulWidget {

  SharedEntriesScreen({super.key});

  @override
  _SharedEntriesScreenState createState() => _SharedEntriesScreenState();
}

class _SharedEntriesScreenState extends State<SharedEntriesScreen> {
  String _selectedSortOption = 'All';
  int _currentPage = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>> _entries = [];
  final List<String> _sortOptions = [ 'Created Date','All'];
  List<ReviewerDetails> reviewerList = [];

  @override
  void initState() {
    super.initState();
    _fetchTeleconEntries(); // Initial fetch
  }

  Future<void> _fetchTeleconEntries() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await sharedTeleconEntries(_currentPage, _selectedSortOption);
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        setState(() {
          _entries = List<Map<String, dynamic>>.from(jsonResponse);
        });
      } else {
        throw Exception('Failed to load entries');
      }
    } catch (error) {
      print('Error fetching entries: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
    _fetchTeleconEntries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    _currentPage = 1;
                    _fetchTeleconEntries();
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _entries.isEmpty && !_isLoading // Check if entries are empty only after loading is complete
                ? Center(child: Text('No entries found'))
                : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                final teleconEntry = entry['teleconEntry'];
                final patient = teleconEntry['patient'];
                final clinician = teleconEntry['clinician'];

                return GestureDetector(
                  onTap: () async{
                  final response = await sharedTeleconEntryDetails(teleconEntry['id']);
                var parsedData = jsonDecode(response.body);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context)=> TeleconEntryDetails(data: parsedData)));
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Teleconsultation Id: ${teleconEntry['id'] ?? 'N/A'}',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text('Patient Name: ${patient['patientName'] ?? 'N/A'}'),
                          Text('Patient ID: ${patient['patientId'] ?? 'N/A'}'),
                          Text('Clinician Name: ${clinician['username'] ?? 'N/A'}'),
                          Text('Clinician Reg No: ${clinician['regNo'] ?? 'N/A'}'),
                          SizedBox(height: 10),
                          Text(
                            'Status:',
                            style: TextStyle(fontSize: 15),
                          ),
                          Text('Reviewed: ${entry['reviewed'] ? "Yes" : "No"}'),
                          Text('Checked: ${entry['checked'] ? "Yes" : "No"}'),
                          SizedBox(height: 10),
                          Text('Created At: ${entry['createdAt'] ?? 'N/A'}'),
                          Text('Updated At: ${entry['updatedAt'] ?? 'N/A'}'),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
        ],
      ),
    );
  }
}
