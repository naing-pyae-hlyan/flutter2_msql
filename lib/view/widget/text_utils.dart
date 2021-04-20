import 'package:flutter/cupertino.dart';

class TextUtils {
  static Text headerText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
