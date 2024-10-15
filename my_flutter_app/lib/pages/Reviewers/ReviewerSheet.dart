import 'dart:convert'; // Import to handle JSON encoding
import 'package:flutter/material.dart';
import '../../URL.dart';
import '../../dto/ReviewerDetailsDto.dart';

class ReviewerSelectionScreen extends StatefulWidget {
  @override
  _ReviewerSelectionScreen createState() => _ReviewerSelectionScreen();
}

class _ReviewerSelectionScreen extends State<ReviewerSelectionScreen> {
  List<ReviewerDetails> reviewerList = [];

  @override
  void initState() {
    super.initState();
    fetchReviewers(); // Fetch the reviewers when the screen initializes
  }

  Future<void> fetchReviewers() async {
    try {
      List<ReviewerDetails> reviewers = await getAllReviewers();
      setState(() {
        reviewerList = reviewers;
      });
    } catch (e) {
      print('Error fetching reviewers: $e');
    }
  }

  void _showReviewerSelectionSheet(BuildContext context) {
    // Show the modal bottom sheet with reviewer selection
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.67, // 2/3 of the screen
        minChildSize: 0.67,
        maxChildSize: 1.0,
        builder: (context, scrollController) {
          return _ReviewerList(
            scrollController: scrollController,
            reviewerList: reviewerList,
            onReviewerSelected: (ReviewerDetails reviewer) {
              String jsonPayload = jsonEncode({'reviewer_id': reviewer.id});
              print('Selected Reviewer JSON Payload: $jsonPayload');
              Navigator.pop(context); // Close the bottom sheet after selection
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Reviewer')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showReviewerSelectionSheet(context),
          child: Text('Select Reviewer'),
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
                ? Center(child: CircularProgressIndicator()) // Show loading if no data
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
                    onReviewerSelected(reviewer); // Call callback when a reviewer is clicked
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
