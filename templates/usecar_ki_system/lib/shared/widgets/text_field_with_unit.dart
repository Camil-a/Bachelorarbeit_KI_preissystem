import 'package:flutter/material.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';

class TextFieldWithUnit extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  


  String? validatorRequired(String? value, {bool isNumber = false}) {
  if (value == null || value.trim().isEmpty) {
    return 'Pflichtfeld';
  }
  if (isNumber && double.tryParse(value) == null) {
    return 'Bitte eine gültige Zahl eingeben';
  }
  return null; // alles ok
}


  const TextFieldWithUnit({
    super.key,
    required this.controller,
    required this.label,
  });

  
 @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return TextFormField(
          controller: controller,
          validator: (value) {
                            // Wenn value null ist UND das Dropdown vom Benutzer nie benutzt wurde
                            if (value == null) return null; 
                            // Wenn value leer ist
                            if (value.isEmpty) return 'Please enter the value';
                            return null;
                          }
                          ,

          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: AppColors.inputFill,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.radiusInput),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.radiusInput),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.radiusInput),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),


            suffixIcon: value.text.trim().isNotEmpty

                ? const Icon(Icons.check, color: AppColors.inputValidIcon, size: 16)
                : null,
          ),
        );
      },
    );
  }

}
