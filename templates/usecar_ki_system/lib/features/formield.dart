// import 'package:flutter/material.dart';

// import '../shared/widgetss/dropdown_field.dart';
// import '../shared/widgetss/infobox.dart';
// import '../shared/widgetss/number_field.dart';
// import '../shared/widgetss/text_field_with_unit.dart';


// // ignore: use_key_in_widget_constructors
// class CarSalesFormPage extends StatefulWidget {
//   @override
//   // ignore: library_private_types_in_public_api
//   _CarSalesFormPageState createState() => _CarSalesFormPageState();
// }

// class _CarSalesFormPageState extends State<CarSalesFormPage> {
//   // Form data variables
//   String? selectedBrand = 'Volkswagen';
//   String? selectedModel = 'Fiesta';
//   String? selectedYear = '2020';
//   String? selectedMonth = 'Januar';
//   String? selectedFuel = 'Benzin';
//   String? selectedTransmission = 'Manuell';
//   String? selectedColor = 'Weiß';
//   String? selectedCondition = 'Ja';
//   String? selectedOfferType = 'privat';
//   String? selectedTimeframe = 'Ich will es nach 24h';
//   String? selectedUsage = 'Privat';
//   String? selectedTarget = 'Deutschland';

//   // Text field controllers
//   TextEditingController kmController = TextEditingController(text: '12.456');
//   TextEditingController powerController = TextEditingController(text: '85');
//   TextEditingController priceController = TextEditingController(text: '12.345');
//   TextEditingController cubicCapacityController = TextEditingController(text: '1.4');
//   TextEditingController co2Controller = TextEditingController(text: '120');
//   TextEditingController tankCapacityController = TextEditingController(text: '50');
//   TextEditingController emptyWeightController = TextEditingController(text: '1200');
//   TextEditingController permittedGrossWeightController = TextEditingController(text: '1800');
//   TextEditingController accelerationController = TextEditingController(text: '10.5');
//   TextEditingController maxSpeedController = TextEditingController(text: '190');

  

//   @override
//   Widget build(BuildContext context) {

//     return Scaffold(


//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,

//         /// custom title with logo and text
//         title: Row(

//           children: [

//             /// logo image
//             Image.asset('assets/images/logo_sfm.png', height: 24), // Replace with actual logo
//             SizedBox(width: 10),

//             Text(
//               'predict usecar',
//               style: TextStyle(color: Colors.black, fontSize: 16),
//             ),
//           ],
//         ),

//         /// action buttons
//         actions: [
//           IconButton(icon: Icon(Icons.help_outline), onPressed: () {}),
//           IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
//         ],
//       ),
      
//       /// body content
//       body: Container(

//         padding: EdgeInsets.all(20),
         
//         // Light gray background
//         color: Color(0xFFF0F0F0),

//         child: SingleChildScrollView(

//           child: Card(
//             elevation: 4,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//             child: Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,

//                 /// form fields and sections
//                 children: [
//                   // Header

//                   Text(
//                     'Gebrautwagen vorhersagen',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 20),



//                   /// details section
//                   Text('Vehicle details', style: TextStyle(fontWeight: FontWeight.bold)),
//                   SizedBox(height: 10),

//                   // Marke Selection
//                   DropdownField(
//                     label: 'Marke',
//                     value: selectedBrand,
//                     onChanged: (v) => setState(() => selectedBrand = v),
//                     items: ['Volkswagen', 'BMW', 'Mercedes', 'Audi', 'Opel', 'Ford'],
//                   ),
//                   SizedBox(height: 10),
                 
//                  /// Model Selection
//                   DropdownField(
//                     label: 'Modell',
//                     value: selectedModel,
//                     onChanged: (v) => setState(() => selectedModel = v),
//                   items: ['Grand Scenic BLUE', 'Ford Focus', 'Nexo Fuel Cell Sports', 'Kango rapid Blue', 'Traffic','Fiesta','Dablo cargo', 'Transit connect'],

//                   ),
                 
                  

//                  /// Registration Date
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: DropdownField(
//                           label: 'Erstzulassung',
//                           value: selectedYear,
//                           onChanged: (v) => setState(() => selectedYear = v),
//                           items: List.generate(20, (i) => '${2025 - i}'),
//                         ),
//                       ),
//                       SizedBox(width: 10),

//                       Expanded(
//                         child: DropdownField(
//                           label: 'Monat',
//                           value: selectedMonth,
//                           onChanged: (v) => setState(() => selectedMonth = v),
//                           items: ['Januar', 'Februar', 'März', 'April', 'Mai', 'Juni', 'Juli', 'August', 'September', 'Oktober', 'November', 'Dezember'],
//                         ),
//                       ),
//                     ],
//                   ),


//                   SizedBox(height: 10),

                  
                
//                   SizedBox(height: 20),

//                   // Vehicle Details
//                   Text('Fahrzeugdetails', style: TextStyle(fontWeight: FontWeight.bold)),

//                    SizedBox(height: 10),

//                   /// Mileage
//                   TextFieldWithUnit(
//                     controller: kmController,
//                     label: 'Kilometerstand',
//                     unit: 'km',
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'PS', controller: powerController, unit: 'PS',)),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'kW', controller: TextEditingController(text: '62'), unit: 'kW')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'l/100km', controller: TextEditingController(text: '5.2'), unit: 'l/100km')),
//                     ],
//                   ),


//                   SizedBox(height: 10),

//                   // Fuel Type
//                   DropdownField(
//                     label: 'Kraftstoff',
//                     value: selectedFuel,
//                     onChanged: (v) => setState(() => selectedFuel = v),
//                     items: ['Benzin', 'Diesel', 'Elektro', 'Hybrid'],

//                   ),
                  
//                   SizedBox(height: 10),
                  
//                   /// Transmission Type and Engine Power
//                   Row(
//                     children: [
//                       Expanded(

//                         child: TextFieldWithUnit(
//                           controller: TextEditingController(text: 'AN'),
//                           label: 'Emission Group',
//                           unit: 'Group',
//                         ),


//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: DropdownField(
//                           label: 'Transmission Type',
//                           value: selectedTransmission,
//                           onChanged: (v) => setState(() => selectedTransmission = v),
//                           items: ['Manuell', 'Automatik'],
//                           isDropdownOnly: true,
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   SizedBox(height: 10),
//                   ///cubic capacity, co2, tank capacity section
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'Cubic capacity', controller: cubicCapacityController,  unit: 'L')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'CO2(g/km)', controller: co2Controller,  unit: 'Km')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Tank Capacity(l)', controller: tankCapacityController, unit: 'L',)),
//                     ],
                    
//                   ),
    
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'Empty Weight(kg)', controller: emptyWeightController, unit: 'Kg')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Permitted gross weight(kg)', controller: permittedGrossWeightController, unit: 'Kg')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Acceleration (0-100 km/h)', controller: accelerationController,  unit: 'km/h')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Max Speed (km/h)', controller: maxSpeedController, unit: 'km/h')),
                      
//                     ],
                    
//                   ),

//                   // Additional Information
//                   // Text('weitere Informationen', style: TextStyle(fontWeight: FontWeight.bold)),
                  
//                   // SizedBox(height: 10),
//                   // DropdownField(
//                   //   label: 'Ist dein Auto fahrbereit und angemeldet?',
//                   //   value: selectedCondition,
//                   //   onChanged: (v) => setState(() => selectedCondition = v),
//                   //   items: ['Ja', 'Nein'],
//                   // ),
                  
//                   // SizedBox(height: 10),
//                   // DropdownField(
//                   //   label: 'Art des Verkaufs?',
//                   //   value: selectedOfferType,
//                   //   onChanged: (v) => setState(() => selectedOfferType = v),
//                   //   items: ['privat', 'gewerblich (Händler, Vermietung)'],
//                   // ),
//                   // SizedBox(height: 10),
                  
//                   // DropdownField(
//                   //   label: 'Wann planst du deinen Fahrverkauf?',
//                   //   value: selectedTimeframe,
//                   //   onChanged: (v) => setState(() => selectedTimeframe = v),
//                   //   items: ['Sofort verfügbar', 'Ich will es nach 24h', 'In den nächsten Monaten'],
//                   // ),

//                   // SizedBox(height: 10),
//                   // Row(
//                   //   children: [
//                   //     Expanded(
//                   //       child: TextFieldWithUnit(
//                   //         controller: priceController,
//                   //         label: 'Wie möchtest du dein Auto verkaufen?',
//                   //         unit: '€',
//                   //       ),
//                   //     ),
//                   //     SizedBox(width: 10),
//                   //     Expanded(
//                   //       child: DropdownField(
//                   //         label: '',
//                   //         value: selectedTarget,
//                   //         onChanged: (v) => setState(() => selectedTarget = v),
//                   //         items: ['Deutschland', 'EU', 'Weltweit'],
//                   //         isDropdownOnly: true,
//                   //       ),
//                   //     ),
//                   //   ],
//                   // ),
                  
//                   //SizedBox(height: 10),
//                   // DropdownField(
//                   //   label: 'Angemeldet als',
//                   //   value: selectedUsage,
//                   //   onChanged: (v) => setState(() => selectedUsage = v),
//                   //   items: ['Privat', 'Gewerbe'],
//                   // ),
//                   // SizedBox(height: 20),

             
              

//                   // Footer text
//                   // Text(
//                   //   'Für die Verarbeitung und Nutzung deiner Daten gilt unsere Datenschutzerklärung.',
//                   //   style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   // ),
//                   SizedBox(height: 10),

//                   // Action Buttons
//                   Row(
//                     children: [
//                       Expanded(
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Submit logic
//                             showDialog(
//                               context: context,
//                               builder: (ctx) => AlertDialog(
//                                 title: Text('Danke!'),
//                                 content: Text('Dein Auto wurde erfolgreich eingestellt.'),
//                                 actions: [TextButton(onPressed: Navigator.of(ctx).pop, child: Text('OK'))],
//                               ),
//                             );
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Color(0xFFE63946), // Red button
//                             padding: EdgeInsets.symmetric(vertical: 12),
//                           ),
//                           child: Text('Predict', style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
//                       SizedBox(width: 10),


//                       // ElevatedButton(
//                       //   onPressed: () {
//                       //     // Cancel or reset
//                       //     setState(() {
//                       //       kmController.clear();
//                       //       powerController.clear();
//                       //       priceController.clear();
//                       //     });
//                       //   },
//                       //   style: ElevatedButton.styleFrom(
//                       //     backgroundColor: Colors.white,
//                       //     foregroundColor: Color(0xFFE63946),
//                       //     side: BorderSide(color: Color(0xFFE63946)),
//                       //     padding: EdgeInsets.symmetric(vertical: 12),
//                       //   ),

//                       //   // child: Row(
//                       //   //   mainAxisSize: MainAxisSize.min,
//                       //   //   children: [
//                       //   //     Icon(Icons.check_circle, size: 16),
//                       //   //     SizedBox(width: 5),
//                       //   //     Text('Mir ein kostenloses Fahrzeugangebot'),
//                       //   //   ],
//                       //   // ),
                      
                      
//                       // ),
                   
                   
//                     ],
//                   ),
               
               
               
               
//                 ],
              
              
              
              
              
              
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Helper widget for brand buttons
  
//   // Widget brandButton(String name, String assetPath) {
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //       border: Border.all(color: Colors.grey[300]!),
//   //       borderRadius: BorderRadius.circular(8),
//   //     ),
//   //     padding: EdgeInsets.all(8),
//   //     child: Column(
//   //       children: [
//   //         Image.asset(assetPath, height: 32, fit: BoxFit.contain),
//   //         SizedBox(height: 4),
//   //         Text(name, style: TextStyle(fontSize: 12)),
//   //       ],
//   //     ),
//   //   );
//   // }



// }

// // // Custom Widgets










//  Text('Fahrzeugdetails', style: TextStyle(fontWeight: FontWeight.bold)),

//                    SizedBox(height: 10),

//                   /// Mileage
//                   TextFieldWithUnit(
//                     controller: kmController,
//                     label: 'Kilometerstand',
//                     unit: 'km',
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'PS', controller: powerController, unit: 'PS',)),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'kW', controller: TextEditingController(text: '62'), unit: 'kW')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'l/100km', controller: TextEditingController(text: '5.2'), unit: 'l/100km')),
//                     ],
//                   ),


//                   SizedBox(height: 10),

//                   // Fuel Type
//                   DropdownField(
//                     label: 'Kraftstoff',
//                     value: selectedFuel,
//                     onChanged: (v) => setState(() => selectedFuel = v),
//                     items: ['Benzin', 'Diesel', 'Elektro', 'Hybrid'],

//                   ),
                  
//                   SizedBox(height: 10),
                  
//                   /// Transmission Type and Engine Power
//                   Row(
//                     children: [
//                       Expanded(

//                         child: TextFieldWithUnit(
//                           controller: TextEditingController(text: 'AN'),
//                           label: 'Emission Group',
//                           unit: 'Group',
//                         ),


//                       ),
//                       SizedBox(width: 10),
//                       Expanded(
//                         child: DropdownField(
//                           label: 'Transmission Type',
//                           value: selectedTransmission,
//                           onChanged: (v) => setState(() => selectedTransmission = v),
//                           items: ['Manuell', 'Automatik'],
//                           isDropdownOnly: true,
//                         ),
//                       ),
//                     ],
//                   ),
                  
//                   SizedBox(height: 10),
//                   ///cubic capacity, co2, tank capacity section
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'Cubic capacity', controller: cubicCapacityController,  unit: 'L')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'CO2(g/km)', controller: co2Controller,  unit: 'Km')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Tank Capacity(l)', controller: tankCapacityController, unit: 'L',)),
//                     ],
                    
//                   ),
    
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Flexible(child: NumberField(label: 'Empty Weight(kg)', controller: emptyWeightController, unit: 'Kg')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Permitted gross weight(kg)', controller: permittedGrossWeightController, unit: 'Kg')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Acceleration (0-100 km/h)', controller: accelerationController,  unit: 'km/h')),
//                       SizedBox(width: 10),
//                       Flexible(child: NumberField(label: 'Max Speed (km/h)', controller: maxSpeedController, unit: 'km/h')),
                      
//                     ],
                    
//                   ),

                  
//                   SizedBox(height: 10),
