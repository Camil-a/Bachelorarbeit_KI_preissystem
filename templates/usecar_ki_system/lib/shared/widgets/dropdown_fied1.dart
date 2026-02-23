
import 'package:flutter/material.dart';

class DropdownFields extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final bool isDropdownOnly;
  //final String? Function(String?)? validator;
  


  String? validatorRequired(String? value, {bool isNumber = false}) {
  if (value == null || value.trim().isEmpty) {
    return 'Pflichtfeld';
  }
  if (isNumber && double.tryParse(value) == null) {
    return 'Bitte eine gültige Zahl eingeben';
  }
  return null; // alles ok
}

  const DropdownFields({
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
        //if (!isDropdownOnly) Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        if (!isDropdownOnly) SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: value,
            validator:   (value) {
                      if (value == null || value.isEmpty) return 'Please enter the value';
                      return null;
                    },

            decoration: InputDecoration(
              labelText: label ?? "please select",
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(),
              suffixIcon: value !=null 
              ? Icon(Icons.check, color: Colors.green, size: 16):null,
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
