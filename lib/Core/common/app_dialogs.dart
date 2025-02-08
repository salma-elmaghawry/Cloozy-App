import 'package:flutter/material.dart';

// Dialog for showing success messages
Future<void> showSuccessDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title:const Text('Success'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Dialog for showing error messages
Future<void> showErrorDialog(BuildContext context, String message) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title:const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Dialog for confirming an action
Future<bool> showConfirmationDialog(BuildContext context, String message) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Action'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  ) ?? false;
}

// Dialog for input
Future<String?> showInputDialog(BuildContext context, String title, String hint) async {
  TextEditingController controller = TextEditingController();

  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(hintText: hint),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(controller.text);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

// Example of a loading dialog
Future<void> showLoadingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // Prevent dismissing by tapping outside
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
