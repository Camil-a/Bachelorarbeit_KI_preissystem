


// ===== DATENMODELL =====
class CarData {
  final String name;
  final String subtitle;
  final String price;
  final String insuranceInfo;
  final String details;
  final List<String> features;
  final String imagePath;
  final DealerData dealer;

  CarData({
    required this.name,
    required this.subtitle,
    required this.price,
    required this.insuranceInfo,
    required this.details,
    required this.features,
    required this.imagePath,
    required this.dealer,
  });
}

class DealerData {
  final String name;
  final double rating;
  final int reviews;
  final String address;
  final String logoPath;

  DealerData({
    required this.name,
    required this.rating,
    required this.reviews,
    required this.address,
    required this.logoPath,
  });
}

// ===== DUMMY-DATEN =====

final CarData kiaEv6 = CarData(
  name: 'Ford Fokus',
  subtitle: 'BASIS 2WD STANDHEIZUNG+RÜCKFAHRKAMERA uvm',
  price: '24.489 €',
  insuranceInfo: 'Versicherung ab 14,04 € mtl.',
  details: 'EZ 10/2022 • 81979 km • 168 kW (228 PS) • Elektro',
  features: [
    'ACC ABSTANDSTEMPOMAT',
    'LED-SCHEINWERFER',
    'ADAPTIVES FAHRWERK',
  ],
  imagePath: 'assets/images/logo_sfm.png',
  dealer: DealerData(
    name: 'Autohaus Liebe',
    rating: 4.5,
    reviews: 102,
    address: '06526 Sangerhausen',
    logoPath: 'assets/images/logo_sfm.png',
  ),
);

final CarData audiEtron = CarData(
  name: 'Audi e-tron',
  subtitle: 'E-TRON SPORTBACK 50 2x S LINE 212./ACC/PANO/MTRX',
  price: '26.945 €',
  insuranceInfo: 'Versicherung ab 17,08 € mtl.',
  details: 'EZ 08/2021 • 91.580 km • 230 kW (313 PS) • Elektro',
  features: ['Ehem. UPE: 92.185,-'],
  imagePath: 'assets/images/logo_sfm.png',
  dealer: DealerData(
    name: 'Reinhardt Automotive GmbH',
    rating: 4.7,
    reviews: 1240,
    address: '58091 Hagen',
    logoPath: 'assets/images/logo_sfm.png',
  ),
);