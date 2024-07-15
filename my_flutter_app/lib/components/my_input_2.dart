import 'package:flutter/material.dart';

class MyInput2 extends StatelessWidget {
  final TextEditingController controller; //controller for the textfield
  final String hintText; //hint text
  final bool obscureText; //obscure text or not
  final String labelText;
  const MyInput2({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.labelText,
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
            SizedBox(width: 10.0), // Space between text and TextField
            Expanded(
              child: TextField(
                controller: controller,
                obscureText: obscureText,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white, // Background color of the TextField
                  hintText: hintText,
                  hintStyle: TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
