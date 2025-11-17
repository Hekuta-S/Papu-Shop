import 'package:flutter/material.dart';

class BotonAdd extends StatelessWidget {
  final VoidCallback onPressed;

  const BotonAdd({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      foregroundColor: Colors.white,
      backgroundColor: Colors.orange,
      shape: CircleBorder(),
      child: const Icon(Icons.add),
    );
  }
}
