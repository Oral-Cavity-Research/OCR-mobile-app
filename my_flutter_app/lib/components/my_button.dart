import 'package:flutter/material.dart';

class my_button extends StatelessWidget {
  final Function()? onTap;
  final String text;

  const my_button({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: InkWell(
          onTap: onTap,
          highlightColor: Theme.of(context).colorScheme.secondary,
          child: Ink(
            decoration: BoxDecoration(
              color:const  Color.fromARGB(255, 53, 143, 216),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              padding: const EdgeInsets.all(25.0),
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ) // Color when the button is pressed
          ),
    );
  }
}
