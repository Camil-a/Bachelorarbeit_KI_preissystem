// import 'package:flutter/material.dart';
// import 'package:usecar_ki_system/features/api_client/form_api_client.dart';
// import 'package:usecar_ki_system/models/car_variable.dart';
// import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_report.dart';
// import 'package:usecar_ki_system/routes/app_route_name.dart';
// import 'package:usecar_ki_system/shared/constants/sizes.dart';
// import '../models/vehicule/technische_features/tchenic_carlisting.dart';
// import '../shared/widgets/dropdown_field.dart';
// import '../shared/widgets/nav_link.dart';
// import '../shared/widgets/number_field.dart';
// import '../shared/widgets/text_field_with_unit.dart';






// class CarSalesFormPage extends StatefulWidget {
//   const CarSalesFormPage({super.key});

//   @override
//   State<CarSalesFormPage> createState() => _CarSalesFormPageState();
// }

// class _CarSalesFormPageState extends State<CarSalesFormPage> {
//   final _formKey = GlobalKey<FormState>();

//   // Constants
//   final int currentYear = DateTime.now().year;
//   double? predictedPrice = 0.0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,

//         /// custom title with logo and text
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             /// logo image
//             Image.asset('assets/images/logo_sfm.png', height: 36),
//             const SizedBox(width: 10),
//             NavLink(label: 'Predict Use Case', routeName: predictCarRouterName),
//             const SizedBox(width: 10),

//             /// RECOMMENDATION LINK
//             NavLink(
//               label: 'Car Recommendation',
//               routeName: recommandRouterName,
//             ),
//           ],
//         ),

//         /// action buttons
//         actions: [
//           IconButton(icon: const Icon(Icons.help_outline), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.person_outline), onPressed: () {}),
//         ],
//       ),

//       /// body content
//       body: SingleChildScrollView(
//         child: Form(
//           key: _formKey,

//           child: Padding(
//             padding: const EdgeInsets.all(Sizes.insetXMedium),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               spacing: Sizes.spacingMedium,

//               /// form fields and sections
//               children: [
//                 // Page Title
//                 const Text(
//                   'Gebrautwagen vorhersagen',
//                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                 ),

//                 /// Vehicle Information Section
//                 Container(
//                   margin: const EdgeInsets.symmetric(vertical: 16),
//                   padding: const EdgeInsets.all(10),

//                   /// box decoration
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),

//                   /// Vehicle Information Fields
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     spacing: 16,
//                     children: [
//                       /// section title
//                       const Text(
//                         'Vehicle details',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),

//                       /// Brand and Modell section
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,

//                         children: [
//                           ///Brand
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Brands',
//                               value: selectedBrand,
//                               onChanged: (v) {
//                                 setState(() => selectedBrand = v);
//                               },
//                               items: [
//                                 'Renault',
//                                 'Ford',
//                                 'Hyundai',
//                                 'Fiat',
//                                 'Opel',
//                               ],
                             
//                             ),
//                           ),


//                           /// Model
//                           SizedBox(width: 10),
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Model',
//                               value: selectedModel,
//                               onChanged: (v) {
//                                 setState(() => selectedModel = v);
//                               },
//                               items: [
//                                 'Grand Scenic BLUE',
//                                 'Focus',
//                                 'Nexo Fuel Cell Sports',
//                                 'Kango rapid Blue',
//                                 'Traffic',
//                                 'Fiesta',
//                                 'Dablo cargo',
//                                 'Transit connect',
//                               ],
                            
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Power Engine Kw and Horsepower
//                       Row(
//                         children: [
//                           /// Engine Power (kw)
//                           Expanded(
//                             child: NumberField(
//                               label: 'Engine Power(kilowatt)',
//                               controller: powerController,
//                               unit: 'KW',
                             
//                             ),
//                           ),
                         
//                           SizedBox(width: 10),

//                           /// Power Horsepower
//                           Expanded(
//                             child: NumberField(
//                               label: 'Engine Power(Horspower)',
//                               controller: horsepowerController,
//                               unit: 'PH',
                            
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Mileage and transmission type
//                       Row(
//                         children: [
//                           Expanded(
//                             child: NumberField(
//                               controller: mileageController,
//                               label: 'Millage',
//                               unit: 'km',
                             
//                             ),
//                           ),

//                           SizedBox(width: 10),

//                           /// Transmission type
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Transmission type',
//                               value: selectedTransmissionType,
//                               onChanged: (v) =>
//                                   setState(() => selectedTransmissionType = v),
//                               items: ['Manuell', 'Automatik'],
                             
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Region and Engine Type
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           /// Fuel Type
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Fuel Type',
//                               value: selectedEngineType,
//                               onChanged: (v) =>
//                                   setState(() => selectedEngineType = v),
//                               items: ['Diesel', 'Electronic', 'Hydrogen'],
                             
//                               // isDropdownOnly: false,
//                             ),
//                           ),

//                           SizedBox(width: 10),

//                           /// Year of manufacture
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Year of manufactuure',
//                               value: selectedYear,
//                               onChanged: (v) =>
//                                   setState(() => selectedYear = v),
//                               items: List.generate(
//                                 currentYear - 1990 + 1,
//                                 (i) => (1990 + i).toString(),
//                               ),
//                               isDropdownOnly: false,
                             
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Registration Date
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           /// day of Tuv
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Next TUV: Day',
//                               value: selectedDay,
//                               onChanged: (v) => setState(() => selectedDay = v),
//                               items:
//                                   //List.generate(20, (i) => '${2025 + i}')
//                                   List.generate(
//                                     12,
//                                     (i) => (i + 1).toString().padLeft(2, '0'),
//                                   ),
                             
//                             ),
//                           ),

//                           /// month of Tuv
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Next TUVMonth',
//                               value: selectedTuvMonth,
//                               onChanged: (v) =>
//                                   setState(() => selectedTuvMonth = v),
//                               items: List.generate(
//                                 12,
//                                 (i) => (i + 1).toString().padLeft(2, '0'),
//                               ),
                            
//                             ),
//                           ),

//                           /// year of first registration
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Next TUV Year',
//                               value: selectedTuvYear,
//                               onChanged: (v) =>
//                                   setState(() => selectedTuvYear = v),
//                               items:
//                                   // List.generate(
//                                   //                       currentYear - 1990 + 1,
//                                   //                       (i) => (1990 + i).toString(),
//                                   //                     )
//                                   List.generate(20, (i) => '${2025 - i}'),
                             
//                             ),
//                           ),
//                           SizedBox(width: 10),
//                         ],
//                       ),

//                       /// Body Style and number of previous own
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,

//                         children: [
//                           /// Nber of previous own
//                           Expanded(
//                             child: TextFieldWithUnit(
//                               controller: nberOfPreviousOwn,
//                               label: 'Nber of previous own',
//                                                          ),
//                           ),

//                           /// Body Style
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Body Style',
//                               value: selectedBodyStyle,
//                               onChanged: (v) =>
//                                   setState(() => selectedBodyStyle = v),
//                               items: [
//                                 'van/Minivan',
//                                 'Kombilimousine',
//                                 'Limousine',
//                                 'Cabrio',
//                                 'transporter',
//                                 'Van',
//                                 'Kombi',
//                               ],
                             
//                             ),
//                           ),
//                         ],
//                       ),

//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           /// Accident History
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Accident history?',
//                               value: selectedAccidentHistory,
//                               onChanged: (v) =>
//                                   setState(() => selectedAccidentHistory = v),
//                               items: ['Yes', 'No'],
                             
//                               // isDropdownOnly: false,
//                             ),
//                           ),

//                           /// Tire Type
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Tire Type',
//                               value: selectedTireType,
//                               onChanged: (v) =>
//                                   setState(() => selectedTireType = v),
//                               items: ['Summer', 'Winter', 'Allseason'],
                            
//                             ),
//                           ),
                        
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),



//                 /// Damage Report Section
//                 Container(
//                   margin: const EdgeInsets.symmetric(
//                     vertical: 16,
//                     horizontal: 10,
//                   ),
//                   padding: const EdgeInsets.all(10),

//                   /// box decoration
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.grey.shade300, width: 1),
//                     borderRadius: BorderRadius.circular(12),
//                   ),

//                   /// doors and seats fields
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     spacing: 16,
//                     children: [
//                       // Titles
//                       Text(
//                         'Damages Report',
//                         style: TextStyle(fontWeight: FontWeight.bold),
//                       ),

//                       /// front and rear car
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged front Car
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged front Car',
//                               value: selectedDamagedFront,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedFront = v),
//                               items: ['Yes', 'No'],
                             
//                             ),
//                           ),

//                           // Damaged rear Car
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged rear Car',
//                               value: selectedDamagedRear,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedRear = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                              
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Left and Right side car
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged left side car
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged left side car',
//                               value: selectedDamagedLeftSide,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedLeftSide = v),
//                               items: ['Yes', 'No'],
                            
//                             ),
//                           ),

//                           // Damaged right side car
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged right side car',
//                               value: selectedDamagedRightSide,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedRightSide = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                           
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Damaged interior and exterior
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged interior
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged interior',
//                               value: selectedDamagedInterior,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedInterior = v),
//                               items: ['Yes', 'No'],
                           
//                             ),
//                           ),

//                           // Damaged Exterior
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged Exterior',
//                               value: selectedDamagedExterior,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedExterior = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                             
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Damaged rim and tire
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged rim
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged rim',
//                               value: selectedDamagedRim,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedRim = v),
//                               items: ['Yes', 'No'],
                            
//                             ),
//                           ),

//                           // Damaged tire
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged tire',
//                               value: selectedDamagedTire,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedTire = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                              
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// Damaged roof beam and seats
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged roof beam
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged roof',
//                               value: selectedDamagedRoofBeam,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedRoofBeam = v),
//                               items: ['Yes', 'No'],
                             
//                             ),
//                           ),

//                           // Damaged seats
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged seats',
//                               value: selectedDamagedSeats,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedSeats = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                          
//                             ),
//                           ),
//                         ],
//                       ),

//                       ///Left and Right door
//                       Row(
//                         spacing: 16,
//                         children: [
//                           // Damaged left door
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged left door',
//                               value: selectedDamagedLeftDoor,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedLeftDoor = v),
//                               items: ['Yes', 'No'],
                             
//                             ),
//                           ),

//                           // Damaged right door
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged right door',
//                               value: selectedDamagedRightDoor,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedRightDoor = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                             
//                             ),
//                           ),
//                         ],
//                       ),

//                       /// interior dirty and damaged carosserie
//                       Row(
//                         spacing: 16,

//                         children: [
//                           // Damaged carosserie
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Damaged carosserie',
//                               value: selectedDamagedCarosserie,
//                               onChanged: (v) =>
//                                   setState(() => selectedDamagedCarosserie = v),
//                               items: ['Yes', 'No'],
                            
//                             ),
//                           ),

//                           // interior dirty
//                           Expanded(
//                             child: DropdownField(
//                               label: 'Interior dirty',
//                               value: selectedInteriorDirty,
//                               onChanged: (v) =>
//                                   setState(() => selectedInteriorDirty = v),
//                               items: ['Yes', 'No'],
//                               isDropdownOnly: false,
                            
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 /// Predict Button and result
//                 Column(
//                   spacing: 16,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,

//                   children: [

//                     /// Predict Button
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () async {

//                           /// validate form and prepare data to send to API
//                           if (_formKey.currentState!.validate()) {
//                             _formKey.currentState!.save();

//                             try {
//                               // prepare data to send to API
//                               final carData = TechnicCarListing(
//                                 brand: selectedBrand ?? '',
//                                 model: selectedModel ?? '',
//                                 year: selectedYear ?? '',
//                                 enginePowerPs:
//                                     int.tryParse(powerController.text) ?? 0,
//                                 enginePowerHs:
//                                     int.tryParse(powerController.text) ?? 0,
//                                 mileage:
//                                     double.tryParse(mileageController.text) ??
//                                     0,
//                                 engineType: selectedEngineType ?? ' ',
//                                 nextTuvYear: selectedTuvYear ?? '',
//                                 nextTuvMonate:
//                                     selectedTuvMonth ?? '', // November
//                                 nextTuvDay: selectedDay ?? '',
//                                 nberPreviousOwners:
//                                     selectedNberPreviousOwners ?? '',
//                                 bodyStyle: selectedBodyStyle ?? '',
//                                 transmissionType:
//                                     selectedTransmissionType ?? '',
//                                 tireType: selectedTireType ?? '',
//                                 accidentHistory: selectedAccidentHistory ?? '',
//                               );

//                               // Damage Report data
//                               final damagedReport = DamageReport(
//                                 damagedFront: selectedDamagedFront == 'Yes'
//                                     ? 1
//                                     : 0,
//                                 damagedRear: selectedDamagedRear == 'Yes'
//                                     ? 1
//                                     : 0,
//                                 damagedLeftSide:
//                                     selectedDamagedLeftSide == 'Yes' ? 1 : 0,
//                                 damagedRightSide:
//                                     selectedDamagedRightSide == 'Yes' ? 1 : 0,
//                                 damagedInterior:
//                                     selectedDamagedInterior == 'Yes' ? 1 : 0,
//                                 damagedExterior:
//                                     selectedDamagedExterior == 'Yes' ? 1 : 0,
//                                 damagedTire: selectedDamageTire == 'Yes'
//                                     ? 1
//                                     : 0,
//                                 damagedRim: selectedDamageRim == 'Yes' ? 1 : 0,
//                                 damagedRoofBeam:
//                                     selectedDamagedRoofBeam == 'Yes' ? 1 : 0,
//                                 damagedLeftDoor:
//                                     selectedDamagedLeftDoor == 'Yes' ? 1 : 0,
//                                 damagedRightDoor:
//                                     selectedDamagedRightDoor == 'Yes' ? 1 : 0,
//                                 damagedSeats: selectedDamagedSeats == 'Yes'
//                                     ? 1
//                                     : 0,
//                                 interiorDirty: selectedInteriorDirty == 'Yes'
//                                     ? 1
//                                     : 0,
//                                 damagedCarosserie:
//                                     selectedDamagedCarosserie == 'Yes' ? 1 : 0,
//                               );

//                               /// result to price predict
//                               final result = await FormApiClient().submitForm(
//                                 carData,
//                                 damagedReport,
//                               ); // send to python

//                               setState(() {
//                                 predictedPrice = result;
//                               });
//                             } catch (e) {
//                               print("FEHLER: $e");
//                             }
//                           }
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Color(0xFFE63946), // Red button
//                           padding: EdgeInsets.symmetric(vertical: 12),
//                         ),

//                         /// predict text
//                         child: Text(
//                           'Predict',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10),

//                     /// Display predicted price if available
//                     if (predictedPrice != null && predictedPrice != 0.0)
//                       SizedBox(
//                        width: double.infinity,
//                         child: Text(
//                           'Predicted Price: \$${(predictedPrice ?? 0).toStringAsFixed(2)}',
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
                 
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // // Custom Widgets
