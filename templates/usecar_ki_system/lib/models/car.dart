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

  // factory Cars.fromJson(Map<String, dynamic> json) {
  //   return Cars(
  //     brand: json['brand'] ?? '',
  //     model: json['model']  ?? '',
  //     fueltype: json['fueltype']  ?? '',
  //     itemId: json['item_id'] ?? 0,
  //     next_Tuv: json['next_tuv']  ?? '',
  //     price: (json['price']  ?? 0.0).toDouble(),
  //     milleage: (json['milleage']  ?? 0.0).toDouble(),
  //     engine_power: json['engine_power']  ?? 0,
      
  //     images: json['images'] == null
  //         ? []
  //         : List<String>.from(json['images']),
  //   );
  // }

  factory Cars.fromJson(Map<String, dynamic> json) {

    print('-----------Json-----------');
    print(json);
  return Cars(
    brand: json['brand'] ?? '',
    model: json['model'] ?? '',
    fueltype: json['fueltype'] ?? '',
    itemId: json['item_id'] ?? 0,
    next_Tuv: json['next_TUV'] ?? '',
    price: (json['Sale_price'] != null)
        ? (json['Sale_price'] is int
            ? (json['Sale_price'] as int).toDouble()
            : double.tryParse(json['Sale_price'].toString()) ?? 0.0)
        : 0.0,
    milleage: (json['mileage'] != null)
        ? (json['mileage'] is int
            ? (json['mileage'] as int).toDouble()
            : double.tryParse(json['milleage'].toString()) ?? 0.0)
        : 0.0,
    engine_power: json['engine_power'] ?? 0,
    images: json['images'] == null
        ? []
        : List<String>.from(json['images']),
  );
}

}
