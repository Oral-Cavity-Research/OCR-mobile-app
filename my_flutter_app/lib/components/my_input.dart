import 'package:flutter/material.dart';

class MyInput extends StatelessWidget {
  final TextEditingController controller; //controller for the textfield
  final String hintText; //hint text
  final bool obscureText; //obscure text or not
  final TextInputType keyboardType; //keyboard type
  const MyInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary,
            )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            )),
            hintText: hintText,
            hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
          )),
    );
  }
}
