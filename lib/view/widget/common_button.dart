import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton(
    this.text, {
    @required this.onPressed,
    this.color = Colors.blue,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      child: Text(text),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      textColor: Colors.white,
      onPressed: onPressed,
    );
  }
}
