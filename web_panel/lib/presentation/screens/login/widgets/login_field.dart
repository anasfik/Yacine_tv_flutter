import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.controller,
    this.label = "label",
    required this.icon,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: label,

        // floatingLabelBehavior: FloatingLabelBehavior.auto,
        // floatingLabelAlignment: FloatingLabelAlignment.center,
        // labelText: label,
        // alignLabelWithHint: true,
        suffixIcon: Icon(icon),
      ),
      controller: controller,
    );
  }
}
