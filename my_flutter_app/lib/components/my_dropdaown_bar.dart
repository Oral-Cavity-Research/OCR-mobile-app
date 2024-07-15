import 'package:flutter/material.dart';

class MyDropdownInput extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?>? onChanged;

  const MyDropdownInput({
    Key? key,
    required this.labelText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 152, 195, 235), // Blue background color
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
        ),
        child: Row(
          children: [
            Text(
              '$labelText:',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 40.0), // Space between text and DropdownButton
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.black),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedItem,
                    onChanged: onChanged,
                    items: items.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
