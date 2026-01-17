
import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const NumberField({
    super.key,
    required this.label,
    required this.controller, required String unit,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(),
        suffixIcon: Icon(Icons.check, color: Colors.green, size: 16),
      ),
    );
  }
}
