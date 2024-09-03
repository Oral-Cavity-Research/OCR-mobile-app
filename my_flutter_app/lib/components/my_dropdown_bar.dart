import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyDropdownInput extends StatelessWidget {
  final String labelText;
  final List<String> items;
  final String selectedItem;
  final ValueChanged<String?>? onChanged;

  const MyDropdownInput({
    super.key,
    required this.labelText,
    required this.items,
    required this.selectedItem,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 2.h),
      child: Container(
        padding: EdgeInsets.all(20.0.w),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 159, 196, 230), // Blue background color
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '$labelText:',
              style: const TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                width: 40.0), // Space between text and DropdownButton
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color.fromARGB(255, 0, 179, 255)),
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
