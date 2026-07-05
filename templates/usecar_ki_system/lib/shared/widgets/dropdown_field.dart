import 'package:flutter/material.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';

class DropdownField extends StatelessWidget {
  final String label;
  final String? value;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final bool isDropdownOnly;

  String? validatorRequired(String? value, {bool isNumber = false}) {
    if (value == null || value.trim().isEmpty) return 'Pflichtfeld';
    if (isNumber && double.tryParse(value) == null) {
      return 'Bitte eine gültige Zahl eingeben';
    }
    return null;
  }

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
        if (!isDropdownOnly) const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: value,
            validator: (value) =>
                (value == null) ? 'Please enter the value' : null,
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
                borderSide: BorderSide(
                  color: value != null ? AppColors.inputValidIcon : AppColors.inputBorder,
                  width: value != null ? 1.5 : 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.radiusInput),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
              suffixIcon: value != null
                  ? const Icon(Icons.check,
                      color: AppColors.inputValidIcon, size: 16)
                  : null,
            ),
            items: items
                .map((item) =>
                    DropdownMenuItem<String>(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
