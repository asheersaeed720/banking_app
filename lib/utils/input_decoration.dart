import 'package:flutter/material.dart';

InputDecoration buildTextFieldInputDecoration(
  context, {
  required String labelText,
  required Widget preffixIcon,
}) {
  // return InputDecoration(
  //   border: const UnderlineInputBorder(
  //     borderSide: BorderSide(color: Colors.grey),
  //   ),
  //   labelText: labelText,
  //   isDense: true,
  //   labelStyle: Theme.of(context).textTheme.headline2!.copyWith(fontSize: 13.0),
  //   prefixIcon: preffixIcon,
  // );
  return InputDecoration(
    labelText: labelText,
    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
    isDense: true,
    counterText: '',
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor)),
    errorStyle: const TextStyle(height: 1.5),
    border: InputBorder.none,
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
