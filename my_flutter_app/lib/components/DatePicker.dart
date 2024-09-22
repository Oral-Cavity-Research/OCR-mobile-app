import 'package:flutter/material.dart';

class DOBPicker extends StatefulWidget {
  final TextEditingController dobController;
  const DOBPicker({Key? key, required this.dobController}) : super(key: key);

  @override
  _DOBPickerState createState() => _DOBPickerState();
}

class _DOBPickerState extends State<DOBPicker> {
  String? selectedMonth;
  String? selectedDay;
  String? selectedYear;

  final List<String> months = [
    'January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<String> days = List.generate(31, (index) => (index + 1).toString());
  final List<String> years = List.generate(100, (index) => (DateTime.now().year - index).toString());

  // Helper function to format the date into "YYYY-MM-DD"
  void formatDOB() {
    if (selectedMonth != null && selectedDay != null && selectedYear != null) {
      String formattedDate = "$selectedYear-${(months.indexOf(selectedMonth!) + 1).toString().padLeft(2, '0')}-${selectedDay!.padLeft(2, '0')}";
      widget.dobController.text = formattedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Date of Birth',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            // Month Dropdown
            Flexible(
              child: DropdownButtonFormField<String>(
                value: selectedMonth,
                hint: const Text('Month'),
                items: months.map((String month) {
                  return DropdownMenuItem<String>(
                    value: month,
                    child: Text(month),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMonth = value;
                    formatDOB(); // Update DOB after month selection
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Month',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(width: 10),
            // Day Input Field
            SizedBox(
              width: 70, // Slightly constrained width for the day input
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value;
                    formatDOB(); // Update DOB after day input
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1 || int.parse(value) > 31) {
                    return 'Invalid day';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 10),
            // Year Input Field
            SizedBox(
              width: 100, // Slightly constrained width for the year input
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    selectedYear = value;
                    formatDOB(); // Update DOB after year input
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty || int.parse(value) < 1900 || int.parse(value) > DateTime.now().year) {
                    return 'Invalid year';
                  }
                  return null;
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
