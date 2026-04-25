import 'package:flutter/material.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';
import 'package:usecar_ki_system/models/car_variable.dart';
import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_form_data_save.dart';

/// Widget that displays a tap-to-toggle damage report form.
/// The parent passes [onChanged] to receive updated [DamagedFormDataSave]
/// whenever the user toggles a damage field.
class DamagedReportPage extends StatefulWidget {
  final Function(DamagedFormDataSave)? onChanged;
  const DamagedReportPage({super.key, this.onChanged});

  @override
  _DamagedReportPageState createState() => _DamagedReportPageState();
}

/// Holds the display data for a single damage tile:
/// the visible [label], the [icon], and the map [key] used in [_damages].
class _DamageItem {
  final String label;
  final IconData icon;
  final String key;
  const _DamageItem(this.label, this.icon, this.key);
}

class _DamagedReportPageState extends State<DamagedReportPage> {
  
  /// Local toggle state for every damage field.
  /// Keys match the strings used in [_notifyChanged] to write back to the
  /// global variables defined in car_variable.dart.
  final Map<String, bool> _damages = {
    'damaged_front': false,
    'damaged_rear': false,
    'damaged_left_side': false,
    'damaged_right_side': false,
    'damaged_exterior': false,
    'damaged_carosserie': false,
    'damaged_roof_beam': false,
    'damaged_left_door': false,
    'damaged_right_door': false,
    'damaged_tire': false,
    'damaged_rim': false,
    'damaged_interior': false,
    'damaged_seats': false,
    'interior_dirty': false,
  };

  // --- Tile definitions grouped by category ---

  /// Exterior body damage fields (front / rear / sides / carosserie / roof).
  static const _exteriorItems = [
    _DamageItem('Front', Icons.north, 'damaged_front'),
    _DamageItem('Rear', Icons.south, 'damaged_rear'),
    _DamageItem('Left Side', Icons.west, 'damaged_left_side'),
    _DamageItem('Right Side', Icons.east, 'damaged_right_side'),
    _DamageItem('Exterior', Icons.directions_car, 'damaged_exterior'),
    _DamageItem('Carosserie', Icons.car_repair, 'damaged_carosserie'),
    _DamageItem('Roof Beam', Icons.roofing, 'damaged_roof_beam'),
  ];

  /// Door and wheel damage fields.
  static const _doorsWheelsItems = [
    _DamageItem('Left Door', Icons.sensor_door, 'damaged_left_door'),
    _DamageItem('Right Door', Icons.sensor_door, 'damaged_right_door'),
    _DamageItem('Tire', Icons.adjust, 'damaged_tire'),
    _DamageItem('Rim', Icons.radio_button_checked, 'damaged_rim'),
  ];

  /// Interior damage and cleanliness fields.
  static const _interiorItems = [
    _DamageItem('Interior', Icons.weekend, 'damaged_interior'),
    _DamageItem('Seats', Icons.airline_seat_recline_normal, 'damaged_seats'),
    _DamageItem('Dirty Interior', Icons.cleaning_services, 'interior_dirty'),
  ];

  // ---------------------------------------------------------------------------
  // State helpers
  // ---------------------------------------------------------------------------

  /// Flips the boolean for [key] and notifies listeners.
  void _toggle(String key) {
    setState(() {
      _damages[key] = !_damages[key]!;
    });
    _notifyChanged();
  }

  /// Writes the current [_damages] state back to the global variables in
  /// car_variable.dart and calls [widget.onChanged] with a fresh
  /// [DamagedFormDataSave] snapshot so the parent form stays in sync.
  void _notifyChanged() {
    // Convert bool → 'Yes'/'No' for the global variables expected by the backend
    selectedDamagedFront      = _damages['damaged_front']!      ? 'Yes' : 'No';
    selectedDamagedRear       = _damages['damaged_rear']!       ? 'Yes' : 'No';
    selectedDamagedLeftSide   = _damages['damaged_left_side']!  ? 'Yes' : 'No';
    selectedDamagedRightSide  = _damages['damaged_right_side']! ? 'Yes' : 'No';
    selectedDamagedExterior   = _damages['damaged_exterior']!   ? 'Yes' : 'No';
    selectedDamagedCarosserie = _damages['damaged_carosserie']! ? 'Yes' : 'No';
    selectedDamagedRoofBeam   = _damages['damaged_roof_beam']!  ? 'Yes' : 'No';
    selectedDamagedLeftDoor   = _damages['damaged_left_door']!  ? 'Yes' : 'No';
    selectedDamagedRightDoor  = _damages['damaged_right_door']! ? 'Yes' : 'No';
    selectedDamagedTire       = _damages['damaged_tire']!       ? 'Yes' : 'No';
    selectedDamagedRim        = _damages['damaged_rim']!        ? 'Yes' : 'No';
    selectedDamagedInterior   = _damages['damaged_interior']!   ? 'Yes' : 'No';
    selectedDamagedSeats      = _damages['damaged_seats']!      ? 'Yes' : 'No';
    selectedInteriorDirty     = _damages['interior_dirty']!     ? 'Yes' : 'No';

    // Build and forward the snapshot to the parent widget
    widget.onChanged?.call(
      DamagedFormDataSave()
        ..selectedDamagedFront      = selectedDamagedFront
        ..selectedDamagedRear       = selectedDamagedRear
        ..selectedDamagedLeftSide   = selectedDamagedLeftSide
        ..selectedDamagedRightSide  = selectedDamagedRightSide
        ..selectedDamagedExterior   = selectedDamagedExterior
        ..selectedDamagedCarosserie = selectedDamagedCarosserie
        ..selectedDamagedRoofBeam   = selectedDamagedRoofBeam
        ..selectedDamagedLeftDoor   = selectedDamagedLeftDoor
        ..selectedDamagedRightDoor  = selectedDamagedRightDoor
        ..selectedDamagedTire       = selectedDamagedTire
        ..selectedDamagedRim        = selectedDamagedRim
        ..selectedDamagedInterior   = selectedDamagedInterior
        ..selectedDamagedSeats      = selectedDamagedSeats
        ..selectedInteriorDirty     = selectedInteriorDirty,
    );
  }

  /// Number of fields currently marked as damaged — shown in the header badge.
  int get _damagedCount => _damages.values.where((v) => v).length;

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
            // Title row with live damage counter badge
            _buildHeader(),
            const SizedBox(height: 16),

            // --- Grouped sections ---
            _buildSection('Exterior', Icons.directions_car_outlined, _exteriorItems),
            const SizedBox(height: 16),
            _buildSection('Doors & Wheels', Icons.sensor_door_outlined, _doorsWheelsItems),
            const SizedBox(height: 16),
            _buildSection('Interior', Icons.airline_seat_recline_normal, _interiorItems),
          ],
        ),
      ),
    );
  }

  /// Header row: section title on the left, damage-count badge on the right.
  /// Badge turns red when at least one field is damaged, green otherwise.
  Widget _buildHeader() {
    final count = _damagedCount;
    return Row(
      children: [
        const Expanded(
          child: Text(
            'Damage Report',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        // Red badge: shows how many fields are marked damaged
        if (count > 0)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.damagedBackground,
              borderRadius: BorderRadius.circular(Sizes.radiusBadge),
              border: Border.all(color: AppColors.damagedBadgeBorder),
            ),
            child: Text(
              '$count damaged',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.damagedBadgeText,
              ),
            ),
          )
        // Green badge: all clear
        else
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.okBadgeBackground,
              borderRadius: BorderRadius.circular(Sizes.radiusBadge),
              border: Border.all(color: AppColors.okBadgeBorder),
            ),
            child: const Text(
              'No damage',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.okBadgeText,
              ),
            ),
          ),
      ],
    );
  }

  /// Renders a labelled section with a horizontal divider and a 2-column tile grid.
  Widget _buildSection(String title, IconData icon, List<_DamageItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header: icon + label + divider line
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
            const Expanded(child: Divider(color: AppColors.sectionDivider, thickness: 1)),
          ],
        ),
        const SizedBox(height: 10),

        // 2-column grid of damage tiles.
        // shrinkWrap + NeverScrollableScrollPhysics so the grid sits inside
        // the parent scroll view without conflict.
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: _tileAspectRatio(context),
          children: items.map(_buildTile).toList(),
        ),
      ],
    );
  }

  /// Calculates tile aspect ratio based on screen width so the tile height
  /// stays ~52 dp on any Android screen size.
  /// Formula: (screenWidth - 32 padding - 8 gap) / 2 columns / 52 dp height
  double _tileAspectRatio(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final cellWidth = (w - 40) / 2;
    return cellWidth / 52;
  }

  /// A single tap-to-toggle tile for one damage field.
  /// Animates its background and border from grey (no damage) → red (damaged).
  Widget _buildTile(_DamageItem item) {
    final damaged = _damages[item.key]!;

    return GestureDetector(
      onTap: () => _toggle(item.key),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: damaged ? AppColors.damagedBackground : AppColors.okBackground,
          borderRadius: BorderRadius.circular(Sizes.radiusTile),
          border: Border.all(
            color: damaged ? AppColors.damagedBorder : AppColors.okBorder,
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          child: Row(
            children: [
              // Category icon — changes colour when damaged
              Icon(
                item.icon,
                size: 17,
                color: damaged ? AppColors.damagedIcon : AppColors.okIcon,
              ),
              const SizedBox(width: 7),

              // Damage label — truncated with ellipsis on very narrow screens
              Expanded(
                child: Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: damaged ? AppColors.damagedText : AppColors.okText,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),

              // Check icon animates between unchecked ↔ checked
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: Icon(
                  damaged ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                  key: ValueKey(damaged), // forces AnimatedSwitcher to rebuild
                  size: 17,
                  color: damaged ? AppColors.damagedIcon : AppColors.okIndicator,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
