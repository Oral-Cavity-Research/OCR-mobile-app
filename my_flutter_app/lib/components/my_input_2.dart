import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyInput2 extends StatelessWidget {
  final TextEditingController controller; //controller for the textfield
  final String hintText; //hint text
  final bool obscureText; //obscure text or not
  final String labelText;
  const MyInput2({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0.w, vertical: 0.05.h),
      child: Container(
        padding: EdgeInsets.all(20.0.h),
        decoration: BoxDecoration(
          color:
              const Color.fromARGB(255, 159, 196, 230), // Blue background color
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
            SizedBox(width: 20.0.w), // Space between text and TextField
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 0, 179, 255)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background color of the TextField
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0.w),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
