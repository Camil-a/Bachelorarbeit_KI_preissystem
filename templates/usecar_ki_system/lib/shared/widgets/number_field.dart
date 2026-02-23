
import 'package:flutter/material.dart';

class NumberField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

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

  const NumberField({
    super.key,
    required this.label,
    required this.controller, required String unit,
  });

 

@override
Widget build(BuildContext context) {
  return ValueListenableBuilder<TextEditingValue>(
    valueListenable: controller,
    builder: (context, value, child) {
      return TextFormField(
        controller: controller,
        validator:  (value) {
                              // Wenn value null ist UND das Dropdown vom Benutzer nie benutzt wurde
                              if (value == null) return null; 
                              // Wenn value leer ist
                              if (value.isEmpty) return 'Please enter the value';
                              return null;
                            },
        keyboardType: TextInputType.number,

        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.grey[100],
          border: const OutlineInputBorder(),

          suffixIcon: value.text.trim().isNotEmpty
              ? const Icon(Icons.check, color: Colors.green, size: 16)
              : null,
        ),
      );
    },
  );
}


}
