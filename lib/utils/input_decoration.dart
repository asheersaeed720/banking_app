import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String labelText,
  required Widget preffixIcon,
}) {
  return InputDecoration(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    labelText: labelText,
    isDense: true,
    labelStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 13.0),
    prefixIcon: preffixIcon,
  );
}

InputDecoration buildPasswordInputDecoration(
  context, {
  required String labelText,
  required Widget suffixIcon,
}) {
  return InputDecoration(
    border: const UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    labelText: labelText,
    isDense: true,
    labelStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 13.0),
    prefixIcon: const Icon(Icons.lock),
    suffixIcon: suffixIcon,
  );
}
