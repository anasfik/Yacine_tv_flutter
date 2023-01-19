import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String label;

  final TextEditingController controller;
  final IconData icon;
  final void Function(String) onChanged;

  const LoginField({
    super.key,
    required this.controller,
    this.label = "label",
    required this.icon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        style: Theme.of(context).textTheme.labelLarge,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: label,
          suffixIcon: Icon(icon, size: 18),
        ),
        controller: controller,
      ),
    );
  }
}
