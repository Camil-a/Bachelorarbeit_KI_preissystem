

class TechnicCarListing {
  final String brand;
  final String model;
  final String year;
  final int enginePowerPs;
  final int enginePowerHs;
  final String nextTuvYear;
  final String nextTuvMonate;
  final String nextTuvDay;
  final String bodyStyle;
  final String transmissionType;
  final String tireType;
  final String accidentHistory;
  final String nberPreviousOwners;
  final double mileage;
  final String engineType;



  // ... other fields
 
  TechnicCarListing({
    required this.brand,
    required this.model,
    required this.year,
    required this.enginePowerPs,
    required this.enginePowerHs,
    required this.transmissionType,
    required this.mileage,
    required this.engineType,
    required this.nextTuvYear,
    required this.nextTuvMonate,
    required this.nextTuvDay,
    required this.nberPreviousOwners,
    required this.bodyStyle,
    required this.tireType,
    required this.accidentHistory,
  });

   
  Map<String, dynamic> toJson() {
  return {
    "Brand": brand,  // Leerzeichen wie im Excel
    "Model": model,
    "year_of_manufacture": year,  // exakt wie Excel
    "Engine_power(kilowatt)": enginePowerPs,
    "Engine_power_(Horsepower)": enginePowerHs,
    "Transmission_type": transmissionType,
    "Mileage": mileage,
    "Fueltype": engineType,
    "nextTUV": '$nextTuvDay.$nextTuvMonate.$nextTuvYear',
    "Nber_previous_owners": nberPreviousOwners ,
    "Body_style": bodyStyle,
    "Tire_type": tireType,
    "Accident_history": accidentHistory
  };
}

  }
