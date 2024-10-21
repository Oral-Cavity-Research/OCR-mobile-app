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
      final response = await shareTeleconEntries(
          _currentPage, _selectedSortOption, widget.patientId);
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
                  print(entry['reviewers']);
                  _showDeleteReviewerSelectionSheet(
                      context, entry['id'], entry['reviewers']);

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
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0)), // Smoother, slightly larger radius
      ),
      backgroundColor: Colors.white, // Clean white background for contrast
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7, // A bit larger to start with
        minChildSize: 0.7,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFFE3F2FD),
                  Color(0xFFBBDEFB)
                ], // Subtle blue gradient
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  child: Text(
                    'Select Reviewer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900], // Professional dark blue
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
                Expanded(
                  child: _ReviewerList(
                    scrollController: scrollController,
                    reviewerList: reviewerList,
                    onReviewerSelected: (ReviewerDetails reviewer) async {
                      // Show a loading indicator
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue[900], // Match color scheme
                            ),
                          );
                        },
                      );

                      final response =
                          await addReviewer(teleconId, reviewer.id);

                      Navigator.pop(context); // Close the loading dialog

                      if (response == 200) {
                        Navigator.pop(context); // Close the bottom sheet
                        responsePopup(
                            context, "Success", "Reviewer added successfully");
                        setState(() {
                          _fetchTeleconEntries(); // Update the entries
                        });
                      } else {
                        responsePopup(context, "Failure",
                            "Error adding reviewer. Error code: $response");
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  List<ReviewerDetails> mapReviewers(List<dynamic> reviewers) {
    return reviewers.map<ReviewerDetails>((reviewer) {
      try {
        print(
            'Mapping reviewer: $reviewer'); // Print each reviewer before mapping
        return ReviewerDetails(
          id: reviewer['id'] ?? '', // Correct key usage
          userName: reviewer['username'] ?? '', // This is correct
          regNo: reviewer['regNo'] ??
              '', // Handle cases where regNo might not be present
        );
      } catch (e) {
        // Print error for debugging
        print('Error mapping reviewer: $e');
        return ReviewerDetails(id: '', userName: '', regNo: ''); // Fallback
      }
    }).toList();
  }

  void _showDeleteReviewerSelectionSheet(
      BuildContext context, String teleconId, List<dynamic> existingReviewers) {
    // Check if existingReviewers is null or empty
    if (existingReviewers == null || existingReviewers.isEmpty) {
      // Handle the case where there are no existing reviewers
      responsePopup(context, "Info", "No existing reviewers to display.");
      // Exit if no reviewers
    }

    // Proceed to map reviewers only if the list is not empty
    List<ReviewerDetails> deleteReviewers = mapReviewers(existingReviewers);

    // Show the bottom sheet
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.7,
        minChildSize: 0.7,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              gradient: LinearGradient(
                colors: [Color(0xFFE3F2FD), Color(0xFFBBDEFB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  child: Text(
                    'Select Reviewer',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      fontFamily: 'Rubik',
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: deleteReviewers.length,
                    itemBuilder: (context, index) {
                      final reviewer = deleteReviewers[index];
                      return ListTile(
                        title: Text(reviewer.userName),
                        subtitle: Text(
                            reviewer.regNo), // If you want to display regNo too
                        onTap: () async {
                          // Show a loading indicator
                          print('Selected reviewer: ${reviewer.userName}');
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Colors.blue[900],
                                ),
                              );
                            },
                          );

                          try {
                            final response =
                                await removeReviewer(teleconId, reviewer.id);
                            Navigator.pop(context); // Close the loading dialog

                            if (response == 200) {
                              Navigator.pop(context); // Close the bottom sheet
                              responsePopup(context, "Success",
                                  "Reviewer removed successfully");
                              setState(() {
                                _fetchTeleconEntries(); // Update the entries
                              });
                            } else {
                              responsePopup(context, "Failure",
                                  "Error removing reviewer. Error code: $response");
                            }
                          } catch (e) {
                            Navigator.pop(
                                context); // Close loading dialog on error
                            responsePopup(context, "Error",
                                "An unexpected error occurred: $e");
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
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
                  : _entries.isEmpty &&
                          !_isLoading // Check if entries are empty only after loading is complete
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      Text(
                                          'Complaint: ${entry['complaint'] ?? 'N/A'}'),
                                      Text(
                                          'Start Time: ${entry['startTime'] ?? 'N/A'}'),
                                      Text(
                                          'End Time: ${entry['endTime'] ?? 'N/A'}'),
                                      Text(
                                          'Findings: ${entry['findings'] ?? 'N/A'}'),
                                      SizedBox(height: 10),
                                      Text(
                                        'Reviewer Names:',
                                        style: TextStyle(fontSize: 15),
                                      ),
                                      reviewers.isNotEmpty
                                          ? ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: reviewers.length,
                                              itemBuilder: (context, index) {
                                                var reviewer = reviewers[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 16.0),
                                                  child: Text(
                                                    reviewer['username'] ??
                                                        'N/A',
                                                    style:
                                                        TextStyle(fontSize: 15),
                                                  ),
                                                );
                                              },
                                            )
                                          : Text(
                                              'No reviewers available.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.grey),
                                            ),
                                      SizedBox(height: 10),
                                      Text(
                                          'Created At: ${entry['createdAt'] ?? 'N/A'}'),
                                      Text(
                                          'Updated At: ${entry['updatedAt'] ?? 'N/A'}'),
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
                  onPressed: _currentPage > 1
                      ? () => _changePage(_currentPage - 1)
                      : null,
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
    return ListView.builder(
      controller: scrollController,
      itemCount: reviewerList.length,
      itemBuilder: (context, index) {
        print(reviewerList[index]);
        final reviewer = reviewerList[index];
        return GestureDetector(
          onTap: () => onReviewerSelected(reviewer),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Clinician Name: ' + reviewer.userName,
                          style: TextStyle(fontSize: 16)),
                      Text('Reg No: ' + reviewer.id,
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
                Icon(Icons.manage_accounts, color: Colors.blue[900]),
              ],
            ),
          ),
        );
      },
    );
  }
}
