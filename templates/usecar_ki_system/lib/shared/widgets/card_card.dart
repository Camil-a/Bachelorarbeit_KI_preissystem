
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';


class CarCard extends StatelessWidget {

  final Cars car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final isPhone = MediaQuery.of(context).size.width < 600;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.radiusButton),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Phone: image on top full-width, info below
            // Wide: image left (260px), info right
            if (isPhone)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(double.infinity, 200),
                  const SizedBox(height: 12),
                  _buildInfo(isPhone: true),
                ],
              )
            else
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(260, 150),
                  const SizedBox(width: 16),
                  Expanded(child: _buildInfo(isPhone: false)),
                ],
              ),

            const Divider(height: 20),

            Text(
              "Autohaus Liebe",
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(double width, double height) {
    final pages = car.images.isNotEmpty
        ? car.images
            .map((url) => ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.radiusTile),
                  child: Image.network(url, fit: BoxFit.cover),
                ))
            .toList()
        : [
            ClipRRect(
              borderRadius: BorderRadius.circular(Sizes.radiusTile),
              child: Image.network(
                'https://via.placeholder.com/260x150',
                fit: BoxFit.cover,
              ),
            )
          ];
    return SizedBox(width: width, height: height, child: PageView(children: pages));
  }

  Widget _buildInfo({required bool isPhone}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${car.brand} ${car.model}',
          style: TextStyle(
            fontSize: isPhone ? 16 : 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          "BASIS 2WD STANDHEIZUNG + RÜCKFAHRKAMERA uvm",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 8),

        // Price + badge — Wrap prevents overflow on small widths
        Wrap(
          spacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              '${car.price.toStringAsFixed(0)}€',
              style: TextStyle(
                fontSize: isPhone ? 16 : 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.cardPriceBadge,
                borderRadius: BorderRadius.circular(Sizes.radiusChip),
              ),
              child: const Text(
                "Sehr guter Preis",
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Details — Wrap so items flow to next line on narrow screens
        Wrap(
          spacing: 4,
          runSpacing: 2,
          children: [
            Text("EZ ${car.next_Tuv}", style: const TextStyle(fontSize: 12)),
            const Text("•", style: TextStyle(fontSize: 12)),
            Text("${car.milleage.toStringAsFixed(0)} km", style: const TextStyle(fontSize: 12)),
            const Text("•", style: TextStyle(fontSize: 12)),
            Text("${car.engine_power} kW", style: const TextStyle(fontSize: 12)),
            const Text("•", style: TextStyle(fontSize: 12)),
            Text(car.fueltype, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }

  
  
  
  
  
  Widget buildRating(double rating) {
  return Row(
    children: List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star, color: AppColors.cardRatingIcon, size: 16);
      } else if (index < rating) {
        return const Icon(Icons.star_half, color: AppColors.cardRatingIcon, size: 16);
      } else {
        return const Icon(Icons.star_border, color: AppColors.cardRatingIcon, size: 16);
      }
    }),
  );
}

}













// class CarCard extends StatelessWidget {
//   final CarData cars;

//   const CarCard({super.key, required this.cars});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       elevation: 4,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//            _buildCarHeader(),
//             const SizedBox(height: 12),
//             _buildDealerInfo(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCarHeader() {
//     return Row(
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 cars.name,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(cars.subtitle),
//               Text(
//                 cars.price,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Text(cars.insuranceInfo, style: const TextStyle(color: Colors.grey)),
//               Text(cars.details, style: const TextStyle(color: Colors.grey)),
//               ...cars.features
//                   .map((feature) => Text('✓ $feature'))
//                   .toList(),
//             ],
//           ),
//         ),
//         const SizedBox(width: 16),
//         Image.asset(
//           cars.imagePath,
//           width: 150,
//           height: 100,
//           fit: BoxFit.cover,
//         ),
//       ],
//     );
//   }

//   Widget _buildDealerInfo() {
//     return Row(
//       children: [
//         Image.asset(
//           cars.dealer.logoPath,
//           width: 30,
//           height: 30,
//         ),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(cars.dealer.name),
//             Row(
//               children: [
//                 const Icon(Icons.star, color: Colors.yellow, size: 16),
//                 Text('${cars.dealer.rating} (${cars.dealer.reviews})'),
//               ],
//             ),
//             Text(cars.dealer.address),
//           ],
//         ),
//         const Spacer(),
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             foregroundColor: Colors.black,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           ),
//           child: const Text('Kontakt'),
//         ),
//         const SizedBox(width: 8),
//         ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.transparent,
//             foregroundColor: Colors.black,
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//           ),
//           child: const Text('Parken'),
//         ),
//       ],
//     );
//   }
// }
