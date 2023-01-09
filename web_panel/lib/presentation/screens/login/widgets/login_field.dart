import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  const LoginField({
    super.key,
    required this.controller,
    this.label = "label",
    required this.icon,
    required this.onChanged,
  });

  final String label;
  final TextEditingController controller;
  final IconData icon;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
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
