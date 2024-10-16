import 'dart:convert';
import 'package:flutter/material.dart';
import '../../URL.dart';
import '../../components/ResponsePopup.dart';
import '../../dto/ReviewerDetailsDto.dart';

class ShareEntriesScreen extends StatefulWidget {
  final String patientId;

  ShareEntriesScreen({super.key, required this.patientId});

  @override
  _ShareEntriesScreenState createState() => _ShareEntriesScreenState();
}

class _ShareEntriesScreenState extends State<ShareEntriesScreen> {
  String _selectedSortOption = 'Updated Date';
  int _currentPage = 1;
  bool _isLoading = false;
  List<Map<String, dynamic>> _entries = [];
  final List<String> _sortOptions = ['Updated Date', 'Created Date'];
  List<ReviewerDetails> reviewerList = [];

  @override
  void initState() {
    super.initState();
    _fetchTeleconEntries(); // Initial fetch
    _fetchReviewers(); // Fetch reviewers when screen initializes
  }

  Future<void> _fetchTeleconEntries() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await shareTeleconEntries(_currentPage, _selectedSortOption, widget.patientId);
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

  Future<void> _fetchReviewers() async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<ReviewerDetails> reviewers = await getAllReviewers();
      setState(() {
        reviewerList = reviewers;
      });
    } catch (e) {
      print('Error fetching reviewers: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showOptionsSheet(BuildContext context, Map<String, dynamic> entry) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Actions for Entry: ${entry['id'] ?? 'N/A'}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.add),
                title: Text('Add Reviewer'),
                onTap: () {
                  _showReviewerSelectionSheet(context, entry['id']);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Remove Reviewer'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete_forever),
                title: Text('Delete Entry'),
                onTap: () async {
                  final response = await deleteEntry(entry['id']);
                  if (response == 200) {
                    await responsePopup(
                      context,
                      "Success",
                      "Teleconsultation Entry deleted successfully!",
                    );
                    setState(() {
                      _fetchTeleconEntries();
                    });
                  } else {
                    await responsePopup(
                      context,
                      "Failure",
                      "Error deleting Teleconsultation Entry: $response",
                    );
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showReviewerSelectionSheet(BuildContext context, String teleconId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.67,
        minChildSize: 0.67,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return _ReviewerList(
            scrollController: scrollController,
            reviewerList: reviewerList,
            onReviewerSelected: (ReviewerDetails reviewer) async {
              final response = await addReviewer(teleconId, reviewer.id);
              if (response == 200) {
                Navigator.pop(context); // Close the sheet after successful addition
                responsePopup(
                    context, "Successful",
                    "Reviewer added successfully");
                setState(() {
                  _fetchTeleconEntries();
                });
              }else{
                Navigator.pop(context);
                responsePopup(
                    context, "Failure",
                    "Error adding reviewer. Error code : $response");
              }
            },
          );
        },
      ),
    );
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
      appBar: AppBar(
        title: Text(
          'Patient Telecon Entries',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue[900],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 59, 158, 215),
                Color.fromARGB(255, 122, 188, 245),
              ],
            ),
          ),
        ),
      ),
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
                ? Center(child: Text('Fetching Entries...'))
                : ListView.builder(
              itemCount: _entries.length,
              itemBuilder: (context, index) {
                final entry = _entries[index];
                List<dynamic> reviewers = entry['reviewers'] ?? [];
                return GestureDetector(
                  onTap: () => _showOptionsSheet(context, entry),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        'Teleconsultation Id: ${entry['id'] ?? 'N/A'}',
                        style: TextStyle(
                          fontFamily: 'Rubik',
                          color: Colors.blue,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          Text('Complaint: ${entry['complaint'] ?? 'N/A'}'),
                          Text('Start Time: ${entry['startTime'] ?? 'N/A'}'),
                          Text('End Time: ${entry['endTime'] ?? 'N/A'}'),
                          Text('Findings: ${entry['findings'] ?? 'N/A'}'),
                          SizedBox(height: 10),
                          Text(
                            'Reviewer Names:',
                            style: TextStyle(fontSize: 15),
                          ),
                          reviewers.isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: reviewers.length,
                            itemBuilder: (context, index) {
                              var reviewer = reviewers[index];
                              return Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text(
                                  reviewer['username'] ?? 'N/A',
                                  style: TextStyle(fontSize: 15),
                                ),
                              );
                            },
                          )
                              : Text(
                            'No reviewers available.',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
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
class _ReviewerList extends StatelessWidget {
  final ScrollController scrollController;
  final List<ReviewerDetails> reviewerList;
  final Function(ReviewerDetails) onReviewerSelected;

  _ReviewerList({
    required this.scrollController,
    required this.reviewerList,
    required this.onReviewerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select a Reviewer',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Expanded(
            child: reviewerList.isEmpty // Check if the list is empty
                ? Center(
                child: CircularProgressIndicator()) // Show loading if no data
                : ListView.builder(
              controller: scrollController,
              itemCount: reviewerList.length,
              itemBuilder: (context, index) {
                ReviewerDetails reviewer = reviewerList[index];
                return ListTile(
                  title: Text(reviewer.userName),
                  subtitle: Text('Reg No: ${reviewer.regNo}'),
                  leading: Icon(Icons.person),
                  onTap: () {
                    onReviewerSelected(
                        reviewer); // Call callback when a reviewer is clicked
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

