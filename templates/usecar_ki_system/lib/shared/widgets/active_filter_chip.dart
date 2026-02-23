
import 'package:flutter/material.dart';

class ActiveFilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onDelete;

  const ActiveFilterChip({super.key, required this.label, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      onDeleted: onDelete,
      backgroundColor: Colors.grey[200],
      labelStyle: const TextStyle(color: Colors.black),
    );
  }
}