
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car.dart';


class CarCard extends StatelessWidget {

  final Cars car;
  const CarCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TOP ROW (Bild + Infos)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [


                /// Cars Image
                // ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: Image.network(
                //    //"${car.images?? "–"}",
                //     car.images.isNotEmpty ? car.images[0] : 'https://via.placeholder.com/260x150',

                //     width: 260,
                //     height: 150,
                //     fit: BoxFit.cover,
                //   ),
                // ),

                  SizedBox(
                    width: 260,
                    height: 150,
                    child: PageView(
                      children: car.images.isNotEmpty
                          ? car.images.map((url) => ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                url,
                                fit: BoxFit.cover,
                              ),
                            )).toList()
                          : [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://via.placeholder.com/260x150',
                                  fit: BoxFit.cover,
                                ),
                              )
                            ],
                    ),
                  ),



                // Expanded(
                //   flex:1,

                //     child: SizedBox(
                //     height: 150,
                //     child: PageView(
                //       children: car.images.isNotEmpty
                //           ? car.images.map((url) => Image.network(url, fit: BoxFit.cover)).toList()
                //           : [Image.network('https://via.placeholder.com/260x150')],
                //     ),
                //     )
                //   ),

                const SizedBox(width: 12),

                /// Infos
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //spacing: 16,
                    children: [

                      ///Name and Model
                      Text(
                       '${car.brand ?? "–"} ${car.model ?? "–"}',

                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        "BASIS 2WD STANDHEIZUNG + RÜCKFAHRKAMERA uvm",
                        style: TextStyle(fontSize: 12),
                      ),

                      const SizedBox(height: 8),

                      /// Preis + Bewertung
                      Row(
                        children: [

                          /// price
                           Text(
                           '${car.price ?? "–"}€',
                            
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius: BorderRadius.circular(6),
                            ),

                            
                            child: const Text(
                              "Sehr guter Preis",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                          )
                        ],
                      ),

                      const SizedBox(height: 6),

                       /// Insurance Info
                       Text(
                        "EZ ${car.next_Tuv ?? "–"} •${car.milleage ?? "–"}Km •${car.engine_power ?? "–"} KW • ${car.fueltype?? "–"} ",
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                )
              ],
            ),


           

            const Divider(height: 20),

            /// DEALER INFO and RATING
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              spacing: 10,
              children: [
                
                 Text(
                    "Autohaus Liebe",
                    style: TextStyle(fontSize: 12),
                  ),
               
 
                    ///dynamic version rating
                              Row(
                  children: [
                    // buildRating(cars.dealer.rating),
                    // const SizedBox(width: 4),
                    // Text(
                    //   '${cars.dealer.rating} (${cars.dealer.reviews})',
                    //   style: const TextStyle(fontSize: 12),
                    // ),
                  ],
                )

              ],
            ),
          ],
        ),
      ),
    );
  }

  
  
  
  
  
  Widget buildRating(double rating) {
  return Row(
    children: List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star, color: Colors.amber, size: 16);
      } else if (index < rating) {
        return const Icon(Icons.star_half, color: Colors.amber, size: 16);
      } else {
        return const Icon(Icons.star_border, color: Colors.amber, size: 16);
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
