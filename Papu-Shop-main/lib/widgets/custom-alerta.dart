import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;

  CustomAlertDialog({required this.message, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Confirmar Borrado'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text('Sí'),
        ),
      ],
    );
  }
}
