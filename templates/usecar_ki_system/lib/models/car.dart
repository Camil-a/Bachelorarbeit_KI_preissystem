class Cars {
  final String brand;
  final String model;
  final String fueltype;
  final int itemId;
  final double price;
  final double milleage;
  final String next_Tuv;
  final int engine_power;
  final List<String> images;

  Cars({
    required this.brand,
    required this.model,
    required this.fueltype,
    required this.itemId,
    required this.next_Tuv,
    required this.price,
    required this.milleage,
    required this.engine_power,
    required this.images,
  });

  
// Factory constructor to create a Cars instance from JSON
  factory Cars.fromJson(Map<String, dynamic> json) {
  return Cars(
    brand: (json['brand'] ?? '').toString(),
    model: (json['model'] ?? '').toString(),
    fueltype: (json['fueltype'] ?? '').toString(),
    itemId: (json['item_id'] is String)
        ? int.tryParse(json['item_id']) ?? 0
        : json['item_id'] ?? 0,
    next_Tuv: (json['next_TUV'] ?? '').toString(),
    price: (json['Sale_price'] != null)
        ? (json['Sale_price'] is int
            ? (json['Sale_price'] as int).toDouble()
            : double.tryParse(json['Sale_price'].toString()) ?? 0.0)
        : 0.0,
    milleage: (json['mileage'] != null)
        ? (json['mileage'] is int
            ? (json['mileage'] as int).toDouble()
            : double.tryParse(json['mileage'].toString()) ?? 0.0)
        : 0.0,
    engine_power: (json['engine_power'] is String)
        ? int.tryParse(json['engine_power']) ?? 0
        : json['engine_power'] ?? 0,
    images: json['images'] == null
        ? []
        : List<String>.from(json['images'].map((e) => e.toString())),
  );
}

}
