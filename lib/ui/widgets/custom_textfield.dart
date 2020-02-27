import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextInputAction action;
  final TextInputType type;
  final TextEditingController controller;
  final String hint;

  const CustomTextField(
      {Key key, this.action, this.type, this.controller, this.hint})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        textInputAction: action,
        keyboardType: type,
        controller: controller,
        decoration: InputDecoration(hintText: hint),
      ),
    );
  }
}
