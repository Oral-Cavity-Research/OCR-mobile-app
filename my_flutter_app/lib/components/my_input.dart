import 'package:flutter/material.dart';

class my_input extends StatelessWidget {
  final TextEditingController controller; //controller for the textfield
  final String hintText; //hint text
  final bool obscureText; //obscure text or not
  const my_input({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
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
