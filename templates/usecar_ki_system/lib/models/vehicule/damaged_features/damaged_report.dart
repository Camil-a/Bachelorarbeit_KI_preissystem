
class DamageReport {
  final int damagedFront;
  final int damagedRear;
  final int damagedLeftSide;
  final int damagedRightSide;
  final int damagedInterior;
  final int damagedExterior;
  final int damagedTire;
  final int damagedRoofBeam;
  final int damagedRim;
  final int damagedLeftDoor;
  final int damagedRightDoor;
  final int damagedSeats;
  final int interiorDirty;
  final int damagedCarosserie;

  const DamageReport({
    required this.damagedFront,
    required this.damagedRear,
    required this.damagedLeftSide,
    required this.damagedRightSide,
    required this.damagedInterior,
    required this.damagedExterior,
    required this.damagedTire,
    required this.damagedRim,
    required this.damagedRoofBeam,
    required this.damagedLeftDoor,
    required this.damagedRightDoor,
    required this.damagedSeats,
    required this.interiorDirty,
    required this.damagedCarosserie,
  });

  /// Map → für API/JSON
  Map<String, dynamic> toJson() {
    return {
      'damaged_front': damagedFront,
      'damaged_rear': damagedRear,
      'damaged_left_side': damagedLeftSide,
      'damaged_right_side': damagedRightSide,
      'damaged_interior': damagedInterior,
      'damaged_exterior': damagedExterior,
      'damaged_tire': damagedTire,
      'damaged_rim': damagedRim,
      'damaged_roof_beam': damagedRoofBeam,
      'damaged_left_door': damagedLeftDoor,
      'damaged_right_door': damagedRightDoor,
      'damaged_seats': damagedSeats,
      'interior_dirty': interiorDirty,
      'damaged_carosserie': damagedCarosserie,
    };
  }

 
}
