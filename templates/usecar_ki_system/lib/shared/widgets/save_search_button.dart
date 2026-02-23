

import 'package:flutter/material.dart' ;

class SaveSearchButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveSearchButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: const Text(
        'Suche speichern',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}