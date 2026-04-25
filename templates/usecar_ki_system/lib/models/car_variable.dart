

  import 'package:flutter/widgets.dart' show TextEditingController;

  



  // String? selectedBrand ;
  // String? selectedModel ;
  // String? selectedYear;
  // String? selectedMonth ;
  // String? selectedDay ;
  // String? selectedFuel ;
  // String? selectedTransmission;
  // String? selectedColor ;
  // String? selectedCondition;
  // String? selectedBodyStyle ;
  // String? selectedLeasingcar;
  // String? selectedPreviousOwnerss ;
  // String? selectedTransmissionType ;
  

  // String? selectedWinterPackage;
  // String? selectedTuvYear ;
  // String? selectedTuvMonth ;
  // String?  selectedEngineType;
  // String? selectedNberPreviousOwners ;
  // String ? selectedAccidentHistory ;


  /// Optische Features
  String? selectedDamageTire ;
  String? selectedDamageRim ;
  String? selectedDamagedLeftDoor;
  String? selectedDamagedRightDoor ;
  String? selectedDamagedMirror ;
  String? selectedDamagedInterior;
  String? selectedDamagedExterior ;
  String? selectedDamagedFront ;
  String? selectedDamagedRear ;
  String?  selectedAccidentH;
  String? selectedDamagedLeftSide ;
  String? selectedDamagedRightSide ;
  String? selectedDamagedSeats ;
  String? selectedInteriorDirty ;
  String? selectedDamagedCarosserie ;
  String? selectedDamagedTire;
  String? selectedDamagedRim;
  String? selectedDamagedRoofBeam;
 





  // Vehicle Information Variables
  String? selectedBrand;
  String? selectedModel;
  String? selectedLeasingcar;
  String? selectedEngineType;
  String? selectedDay;
  String? selectedTuvMonth;
  String? selectedTuvYear;
  String? selectedYear;
  String? selectedBodyStyle;
  String? selectedTransmissionType;
  String? selectedTireType;
  String? selectedRimType;
  String? selectedWinterPackage;
  
  
  // Damage Variables - all as String
  
  
  String? selectedAccidentHistory;
  String? selectedNberPreviousOwners;

  // Controllers
  final TextEditingController nberOfPreviousOwn = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  final TextEditingController tankCapacityController = TextEditingController();
  final TextEditingController cubicCapacityController = TextEditingController();
  final TextEditingController powerController = TextEditingController();
  final TextEditingController emptyWeightController = TextEditingController();
  final TextEditingController permittedGrossWeightController = TextEditingController();
  final TextEditingController maxSpeedController = TextEditingController();
  final TextEditingController horsepowerController = TextEditingController();
 



final currentYear = DateTime.now().year;

// Jahre von 1990 bis heute
final years = List.generate(currentYear - 1990 + 1, (i) => (1990 + i).toString());

// Monate 1–12
final months = List.generate(12, (i) => (i + 1).toString());

// Tage 1–31
final days = List.generate(31, (i) => (i + 1).toString()); 

  


