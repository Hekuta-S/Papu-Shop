import 'package:flutter/material.dart';

class BotonBorrar extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonBorrar({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      shape: CircleBorder(),
      child: const Icon(Icons.cancel_schedule_send),
    );
  }
}
