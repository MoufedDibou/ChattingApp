// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Color color;
  final String name;
  final VoidCallback onPressed;

  MyButton({required this.name, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
            onPressed: onPressed, minWidth: 190, height: 40, child: Text(name)),
      ),
    );
  }
}
