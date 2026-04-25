import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car_variable.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/vehicule_Form_data_save.dart';
import 'package:usecar_ki_system/shared/widgets/dropdown_field.dart';
import 'package:usecar_ki_system/shared/widgets/number_field.dart';
import 'package:usecar_ki_system/shared/widgets/text_field_with_unit.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';

/// Form card collecting all technical vehicle details.
/// Writes selections into the global variables defined in car_variable.dart.
/// Calls [onChanged] after every field update so the parent form stays in sync.
class VehicleCard extends StatefulWidget {
  final Function(VehiculeFormDataSaved) onChanged;
  const VehicleCard({required this.onChanged, super.key});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  int get _currentYear => DateTime.now().year;

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Sizes.radiusCard)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Section 1: Vehicle Identity ──────────────────────────────────
            _section('Vehicle', Icons.directions_car_outlined, [

              // Brand and model side by side as dropdowns with fixed options
              _row2(

                //brand
                DropdownField(
                  label: 'Brand',
                  value: selectedBrand,
                  onChanged: (v) => setState(() => selectedBrand = v),
                  items: const [
                    'Renault',
                    'Ford',
                    'Hyundai',
                    'Fiat',
                    'Opel',
                    'Volkswagen',
                    'Mercedes-Benz',
                  ],
                ),

                //model
                DropdownField(
                  label: 'Model',
                  value: selectedModel,
                  onChanged: (v) => setState(() => selectedModel = v),
                  items: const [
                    'Grand Scenic BLUE',
                    'Focus',
                    'Nexo Fuel Cell Sports',
                    'Kango rapid Blue',
                    'Traffic',
                    'Fiesta',
                    'Dablo cargo',
                    'Transit connect',
                    'Tuscson',
                    'i30',
                    'Kuga',
                    'Captur',
                    'Clio',
                    'Polo',
                    'Golf',
                    'Passat',
                    'Caddy',
                    'Tiguan',
                    'A-Klasse',
                    'C-Klasse',
                    'E-Klasse',
                  ],
                ),
              ),
              
              // Year of manufacture and body style side by side, year is a dropdown with a range of years
              _row2(

                //year of manufacture
                DropdownField(
                  label: 'Year of Manufacture',
                  value: selectedYear,
                  onChanged: (v) => setState(() => selectedYear = v),
                  items: List.generate(
                    _currentYear - 1990 + 1,
                    (i) => (1990 + i).toString(),
                  ),
                  isDropdownOnly: false,
                ),
                
                //body style
                DropdownField(
                  label: 'Body Style',
                  value: selectedBodyStyle,
                  onChanged: (v) => setState(() => selectedBodyStyle = v),
                  items: const [
                    'van/Minivan',
                    'Kombilimousine',
                    'Limousine',
                    'Cabrio',
                    'Transporter',
                    'Van',
                    'Kombi',
                  ],
                ),
              ),
            ]),

            // ── Section 2: Engine & Performance ─────────────────────────────
            _section('Engine & Performance', Icons.speed_outlined, [
               
               //Horsepower and engine power side by side, with units in the field
              _row2(
                NumberField(
                  label: 'Engine Power',
                  controller: powerController,
                  unit: 'kW',
                ),
                NumberField(
                  label: 'Horsepower',
                  controller: horsepowerController,
                  unit: 'PS',
                ),
              ),
             
             // Fuel type and transmission side by side as dropdowns
              _row2(
                DropdownField(
                  label: 'Fuel Type',
                  value: selectedEngineType,
                  onChanged: (v) => setState(() => selectedEngineType = v),
                  items: const ['Diesel', 'Electric', 'Hydrogen', 'Benzin'],
                ),
                DropdownField(
                  label: 'Transmission',
                  value: selectedTransmissionType,
                  onChanged: (v) =>
                      setState(() => selectedTransmissionType = v),
                  items: const ['Manuell', 'Automatik'],
                ),
              ),
            ]),

            // ── Section 3: Usage & Condition ─────────────────────────────────
            _section('Usage & Condition', Icons.bar_chart_outlined, [
              _row2(
                NumberField(
                  label: 'Mileage',
                  controller: mileageController,
                  unit: 'km',
                ),
                TextFieldWithUnit(
                  controller: nberOfPreviousOwn,
                  label: 'Previous Owners',
                ),
              ),
              _row2(
                DropdownField(
                  label: 'Accident History',
                  value: selectedAccidentHistory,
                  onChanged: (v) =>
                      setState(() => selectedAccidentHistory = v),
                  items: const ['Yes', 'No'],
                ),
                DropdownField(
                  label: 'Tire Type',
                  value: selectedTireType,
                  onChanged: (v) => setState(() => selectedTireType = v),
                  items: const ['Summer', 'Winter', 'Allseason'],
                ),
              ),
            ]),

            // ── Section 4: Next TÜV ──────────────────────────────────────────
            _section('Next TÜV', Icons.verified_outlined, [
              // Three compact dropdowns side-by-side for day / month / year
              _row3(
                DropdownField(
                  label: 'Day',
                  value: selectedDay,
                  onChanged: (v) => setState(() => selectedDay = v),
                  items: List.generate(
                    31,
                    (i) => (i + 1).toString().padLeft(2, '0'),
                  ),
                ),
                DropdownField(
                  label: 'Month',
                  value: selectedTuvMonth,
                  onChanged: (v) => setState(() => selectedTuvMonth = v),
                  items: List.generate(
                    12,
                    (i) => (i + 1).toString().padLeft(2, '0'),
                  ),
                ),
                DropdownField(
                  label: 'Year',
                  value: selectedTuvYear,
                  onChanged: (v) => setState(() => selectedTuvYear = v),
                  // Future years only — TÜV is always ahead
                  items: List.generate(10, (i) => '${_currentYear + i}'),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Layout helpers
  // ---------------------------------------------------------------------------

  /// Labelled section with an icon, a horizontal divider, and spaced [children].
  Widget _section(String title, IconData icon, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header row
          Row(
            children: [
              Icon(icon, size: 16, color: AppColors.sectionIcon),
              const SizedBox(width: 6),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.sectionLabel,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Divider(color: AppColors.sectionDivider, thickness: 1),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Field rows with consistent vertical spacing
          ...children.map(
            (child) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  /// Two equally-sized fields side-by-side with a fixed gap.
  Widget _row2(Widget left, Widget right) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        const SizedBox(width: 10),
        Expanded(child: right),
      ],
    );
  }

  /// Three equally-sized fields side-by-side — used for the TÜV date row.
  Widget _row3(Widget a, Widget b, Widget c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: a),
        const SizedBox(width: 8),
        Expanded(child: b),
        const SizedBox(width: 8),
        Expanded(child: c),
      ],
    );
  }
}
