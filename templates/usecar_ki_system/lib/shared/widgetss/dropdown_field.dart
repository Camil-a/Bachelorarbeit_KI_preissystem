
import 'package:flutter/material.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final bool isDropdownOnly;

  const DropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.onChanged,
    required this.items,
    this.isDropdownOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!isDropdownOnly) Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        if (!isDropdownOnly) SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.check, color: Colors.green, size: 16),
            ),
            items: items.map((item) {
              return DropdownMenuItem<String>(value: item, child: Text(item));
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
