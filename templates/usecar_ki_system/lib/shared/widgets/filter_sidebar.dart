// ===== SEITENKOMPONENTEN =====
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/shared/widgets/filter_group.dart';
import 'package:usecar_ki_system/shared/widgets/save_search_button.dart';

class FilterSidebar extends StatelessWidget {
  const FilterSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      color: Colors.grey[50],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SaveSearchButton(onPressed: () {}),
          const SizedBox(height: 24),
          FilterGroup(
            title: 'Fahrzeugzustand',
            children: [const Text('Beliebig')],
          ),
          FilterGroup(
            title: 'Marke, Modell, Variante',
            children: [const Text('Beliebig')],
          ),
          FilterGroup(
            title: 'Zahlungsart',
            children: [
              _buildFilterButton('Kaufen'),
              _buildFilterButton('Leasen'),
            ],
            isExpanded: true,
          ),
          FilterGroup(
            title: 'Preis',
            children: [
              _buildDropdown(['von', '5.000', '10.000', '15.000']),
              const Text('bis'),
              _buildDropdown(['bis', '15.000', '20.000', '25.000']),
            ],
            isExpanded: true,
          ),
          FilterGroup(
            title: 'Außenfarbe',
            children: [
              _buildColorSwatch(Colors.black),
              _buildColorSwatch(Colors.brown),
              _buildColorSwatch(Colors.grey),
              _buildColorSwatch(Colors.yellow),
              _buildColorSwatch(Colors.orange),
              _buildColorSwatch(Colors.blue),
              _buildColorSwatch(Colors.red),
              _buildColorSwatch(Colors.green),
            ],
            isExpanded: true,
          ),
          // Weitere Filtergruppen analog...
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildDropdown(List<String> items) {
    return DropdownButton<String>(
      value: items.first,
      items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
      onChanged: (_) {},
      style: const TextStyle(fontSize: 12),
    );
  }

  Widget _buildColorSwatch(Color color) {
    return Container(
      width: 24,
      height: 24,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
