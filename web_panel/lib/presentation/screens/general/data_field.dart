import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  const DataField({
    super.key,
    required this.hint,
    this.onChanged,
    this.controller,
  });

  final String hint;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            hint,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextField(
            controller: controller,
            onChanged: onChanged,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              hintText: hint,
            ),
          ),
        ],
      ),
    );
  }
}
