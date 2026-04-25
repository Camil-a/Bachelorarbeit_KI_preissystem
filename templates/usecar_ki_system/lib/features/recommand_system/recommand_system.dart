
import 'package:flutter/material.dart';

import 'recomand_car_listing_page.dart';


class RecommandCarApp extends StatelessWidget {
  const RecommandCarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Suche',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RecommandCarListingPage(),
    );
  }
}




// class SaveSearchButton extends StatelessWidget {
//   final VoidCallback onPressed;

//   const SaveSearchButton({super.key, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,

//       // save button
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.red,
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       ),
//       child: const Text(
//         'Suche speichern',
//         style: TextStyle(fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }




