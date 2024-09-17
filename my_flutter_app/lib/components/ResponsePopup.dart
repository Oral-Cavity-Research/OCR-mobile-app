import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> responsePopup(BuildContext context, String title, String message) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Close the popup
            },
          ),
        ],
      );
    },
  );
}
