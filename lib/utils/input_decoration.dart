import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String labelText,
  required Widget preffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 1.0,
      ),
    ),
    labelText: labelText,
    labelStyle: const TextStyle(color: Colors.black87),
    isDense: true,
    prefixIcon: preffixIcon,
  );
}

InputDecoration buildPasswordInputDecoration(
  context, {
  required String labelText,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.shade400,
        width: 1.0,
      ),
    ),
    labelText: labelText,
    isDense: true,
    labelStyle: const TextStyle(color: Colors.black87),
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: suffixIcon,
  );
}
