import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextUtils {
  static AutoSizeText headerText(String text) {
    return AutoSizeText(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
