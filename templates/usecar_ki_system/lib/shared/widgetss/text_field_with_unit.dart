


import 'package:flutter/material.dart';

class TextFieldWithUnit extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String unit;

  const TextFieldWithUnit({
    super.key,
    required this.controller,
    required this.label,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.check, color: Colors.green, size: 16),
            ),
          ),
        ),
        SizedBox(width: 5),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
          ),
          child: Text(unit),
        ),
      ],
    );
  }
}