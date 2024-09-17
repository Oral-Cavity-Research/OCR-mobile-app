import 'package:flutter/material.dart';

class MultipleChoiceSelector extends StatefulWidget {
  final List<String> options; // List of options
  final String question; // The question or prompt
  final Function(List<int>) onSelectionChanged; // Callback function

  const MultipleChoiceSelector(
      {Key? key,
      required this.options,
      required this.question,
      required this.onSelectionChanged})
      : super(key: key);

  @override
  _MultipleChoiceSelectorState createState() => _MultipleChoiceSelectorState();
}

class _MultipleChoiceSelectorState extends State<MultipleChoiceSelector> {
  List<String> selectedOptions = []; // Holds the selected options
  List<int> selectedIndexes = []; // Holds the indexes of the selected options

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Align to the start to reduce center gaps
      children: [
        // Adding this to control padding between question and list
        Padding(
          padding:
              const EdgeInsets.only(bottom: 8.0), // Adjust padding as needed
          child: Center(
            child: Text(
              widget.question,
              style: const TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                fontFamily: 'Rubik',
              ),
            ),
          ),
        ),

        ListView.builder(
          shrinkWrap: true, // Ensures the ListView takes minimum space
          physics: const NeverScrollableScrollPhysics(), // Disable scrolling
          padding: EdgeInsets.zero, // Remove internal padding from the ListView
          itemCount: widget.options.length,
          itemBuilder: (context, index) {
            String option = widget.options[index];
            bool isSelected = selectedOptions.contains(option);

            return CheckboxListTile(
              title: Text(
                option,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              dense: true, // Reduce the height of the ListTile
              visualDensity:
                  VisualDensity.compact, // Reduce the vertical spacing
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 21,
                  vertical: 0), // Remove padding from CheckboxListTile
              value: isSelected,
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedOptions.add(option);
                    selectedIndexes
                        .add(index); // Add the index to selectedIndexes
                  } else {
                    selectedOptions.remove(option);
                    selectedIndexes
                        .remove(index); // Remove the index from selectedIndexes
                  }
                  widget.onSelectionChanged(
                      selectedIndexes); // Call the callback function
                });
              },
            );
          },
        ),
      ],
    );
  }
}
