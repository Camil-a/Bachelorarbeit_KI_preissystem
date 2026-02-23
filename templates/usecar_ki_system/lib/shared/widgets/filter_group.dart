

// ===== WIEDERVERWENDBARE KOMPONENTEN =====
import 'package:flutter/material.dart';

class FilterGroup extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final bool isExpanded;

  const FilterGroup({
    super.key,
    required this.title,
    required this.children,
    this.isExpanded = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          if (isExpanded) ...children,
          if (!isExpanded) ...[
            _buildCompactFilter(children),
            TextButton(
              onPressed: () {},
              child: const Text('ändern', style: TextStyle(color: Colors.red)),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCompactFilter(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: children
            .map((child) => Expanded(child: child))
            .toList(growable: false),
      ),
    );
  }
}
