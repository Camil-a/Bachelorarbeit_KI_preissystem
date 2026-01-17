import 'package:flutter/material.dart';

import '../shared/widgetss/dropdown_field.dart';
import '../shared/widgetss/infobox.dart';
import '../shared/widgetss/number_field.dart';
import '../shared/widgetss/text_field_with_unit.dart';

// ignore: use_key_in_widget_constructors
class CarSalesFormPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _CarSalesFormPageState createState() => _CarSalesFormPageState();
}

class _CarSalesFormPageState extends State<CarSalesFormPage> {
  // Form data variables
  String? selectedBrand = 'Renault';
  String? selectedModel = 'Fiesta';
  String? selectedYear = '2020';
  String? selectedMonth = 'Januar';
  String? selectedFuel = 'Benzin';
  String? selectedTransmission = 'Manuell';
  String? selectedColor = 'Weiß';
  String? selectedCondition = 'Ja';
  String? selectedOfferType = 'privat';
  String? selectedTimeframe = 'Ich will es nach 24h';
  String? selectedUsage = 'Privat';
  String? selectedTargets = 'Deutschland';
  String? selectedBodyStyle = 'Kombi';
  String? selectedLeasingcar = 'No';
  String? selectedReadyToDrive = 'Yes';
  String? selectedPreviousOwnerss = '1';
  String? selectedTransmissionType = 'mechanical';
  String? selectedTireType = 'Summer';
  String? selectedRimType = 'alloy wheels';
  String? selectedWinterPackage = 'No';

  // Text field controllers
  TextEditingController kmController = TextEditingController(text: '12.456');
  TextEditingController powerController = TextEditingController(text: '85');
  TextEditingController priceController = TextEditingController(text: '12.345');
  TextEditingController cubicCapacityController = TextEditingController(
    text: '1.4',
  );
  TextEditingController co2Controller = TextEditingController(text: '120');
  TextEditingController tankCapacityController = TextEditingController(
    text: '50',
  );
  TextEditingController emptyWeightController = TextEditingController(
    text: '1200',
  );
  TextEditingController permittedGrossWeightController = TextEditingController(
    text: '1800',
  );
  TextEditingController accelerationController = TextEditingController(
    text: '10.5',
  );
  TextEditingController maxSpeedController = TextEditingController(text: '190');
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        /// custom title with logo and text
        title: Row(
          children: [
            /// logo image
            Image.asset(
              'assets/images/logo_sfm.png',
              height: 24,
            ), // Replace with actual logo
            SizedBox(width: 10),

            Text(
              'predict usecar',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),

        /// action buttons
        actions: [
          IconButton(icon: Icon(Icons.help_outline), onPressed: () {}),
          IconButton(icon: Icon(Icons.person_outline), onPressed: () {}),
        ],
      ),

      /// body content
      body: Form(
      


        child: SingleChildScrollView(
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                /// form fields and sections
                children: [
                  // Page Title
                  Text(
                    'Gebrautwagen vorhersagen',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),

                  /// Vehicle Information Section
                  Container(

                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.all(10),
                    
                    /// box decoration
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),

                 /// Vehicle Information Fields
                 child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
               
                      children: [
                        /// section title
                        Text(
                          'Vehicle details',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),

                        // Marke Selection
                        DropdownField(
                          label: 'Brands',
                          value: selectedBrand,
                          onChanged: (v) => setState(() => selectedBrand = v),
                          items: [
                            'Renault',
                            'Ford',
                            'Hyundai',
                            'Fiat',
                            'Opel',
                            'Ford',
                          ],
                        ),
                        SizedBox(height: 10),

                        /// Model Selection
                        DropdownField(
                          label: 'Modell',
                          value: selectedModel,
                          onChanged: (v) => setState(() => selectedModel = v),
                          items: [
                            'Grand Scenic BLUE',
                            'Ford Focus',
                            'Nexo Fuel Cell Sports',
                            'Kango rapid Blue',
                            'Traffic',
                            'Fiesta',
                            'Dablo cargo',
                            'Transit connect',
                          ],
                        ),
              
                       SizedBox(height: 10),
                       
                        /// Is leasingcar
                        DropdownField(
                          label: 'Is leasingcar?',
                          value: selectedLeasingcar,
                          onChanged: (v) => setState(() => selectedLeasingcar = v),
                          items: [
                            'Yes',
                            'No',
                          ],
                        ),
                        
                        /// Registration Date
                        SizedBox(height: 10),
                        Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            /// year of first registration
                            Expanded(
                              child: DropdownField(
                                label: 'Erstzulassung',
                                value: selectedYear,
                                onChanged: (v) =>
                                    setState(() => selectedYear = v),
                                items: List.generate(20, (i) => '${2025 - i}'),
                              ),
                            ),
                            SizedBox(width: 10),
                            
                            /// month of first registration
                            Expanded(
                              child: DropdownField(
                                label: 'Monat',
                                value: selectedMonth,
                                onChanged: (v) =>
                                    setState(() => selectedMonth = v),
                                items: [
                                  'Januar',
                                  'Februar',
                                  'März',
                                  'April',
                                  'Mai',
                                  'Juni',
                                  'Juli',
                                  'August',
                                  'September',
                                  'Oktober',
                                  'November',
                                  'Dezember',
                                ],
                              ),
                            ),
                          ],
                        ),
                      

                        SizedBox(height: 10),
                        
                        /// Color and Leasingcar
                         Row(
                       crossAxisAlignment: CrossAxisAlignment.start,

    
                             children: [

                            Flexible(

                            ///color
                          child: 
                          TextFieldWithUnit(
                          controller: kmController,
                          label: 'Color',
                          unit: 'Color',
                        ), 
                           ),

                        SizedBox(width: 10),

                        /// Leasingcar
                          Flexible(
                            
                          child: DropdownField(

                          label: 'Leasingcar',
                          value: selectedLeasingcar,
                          onChanged: (v) => setState(() => selectedTransmission = v),
                          items: ['Yes', 'No'],
                          isDropdownOnly: true,
                        ),
                          ),

                          ],



                         ),



                          SizedBox(height: 10),
                        /// Body Style and Transmission type
                         Row(
                       crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                        /// Body Style
                           Flexible(
                     child:DropdownField(
                          label: 'Body Style',
                          value: selectedBodyStyle,
                          onChanged: (v) => setState(() => selectedBodyStyle = v),
                          items: ['van/Minivan', 'Kombilimousine', 'Limousine', 'Cabrio','transporter','Van','Kombi'],

                        ),
                           ),
                     
                      /// Transmission type
                       SizedBox(width: 10),
                         Flexible(

                     child: DropdownField(
                          label: 'Transmission type',
                          value: selectedTransmissionType,
                          onChanged: (v) => setState(() => selectedTransmissionType = v),
                          items: ['6 Gear mechanical', 'mechanical', '5 Gear mechanical', '6 Gear automatik','8 Gear automatik'],

                        ),
                           ),
                    
                          ],
                          
                          )
                      
                      ],


                    ),
                  ),

                  SizedBox(height: 20),

                  /// Technical Features Section
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        /// Titles
                        Text(
                          'Technic Features',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        SizedBox(height: 20),

                        /// Mileage
                        TextFieldWithUnit(
                          controller: kmController,
                          label: 'Millage',
                          unit: 'km',
                        ),
                        SizedBox(height: 10),

                        /// Power Engine
                        Row(
                          children: [
                            Flexible(
                              child: NumberField(
                                label: 'PS',
                                controller: powerController,
                                unit: 'PS',
                              ),
                            ),

                            SizedBox(width: 10),
                            Flexible(
                              child: NumberField(
                                label: 'kW',
                                controller: TextEditingController(text: '62'),
                                unit: 'kW',
                              ),
                            ),
                            
                            SizedBox(width: 10),
                            Flexible(
                              child: NumberField(
                                label: 'l/100km',
                                controller: TextEditingController(text: '5.2'),
                                unit: 'l/100km',
                              ),
                            ),
                          
                          ],
                        ),
                      
                        SizedBox(height: 10),
                   /// Cubic Capacity , CO2 Emission, Tank Capacity
                  Row(
                    children: [
                      Flexible(child: NumberField(label: 'Empty Weight(kg)', controller: emptyWeightController, unit: 'Kg')),
                      SizedBox(width: 10),
                      Flexible(child: NumberField(label: 'Permitted gross weight(kg)', controller: permittedGrossWeightController, unit: 'Kg')),
                      SizedBox(width: 10),
                      Flexible(child: NumberField(label: 'Acceleration (0-100 km/h)', controller: accelerationController,  unit: 'km/h')),
                      SizedBox(width: 10),
                      Flexible(child: NumberField(label: 'Max Speed (km/h)', controller: maxSpeedController, unit: 'km/h')),
                      
                    ],
                  ),

                  SizedBox(height: 20),

                  Container(
                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: Color(0xFFF9F9F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                      /// Titles
                        Text(
                          'Zulassung & Versicherung',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
 

                      ],
                      ),
                  )


                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  
                  ///Rim and Tires Section
                  Container(
                    
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    
                    /// box decoration
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade300, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    
                    ///tires and rims fields
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                      /// Titles
                        Text(
                          'Rim and Tires',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      
                      // Tire Type, Rim Type, Winter Package
                      Container(

                        padding: EdgeInsets.all( 10),
                        child: Row(
                          children: [

                            /// Tire Type
                            Flexible(
                              child: DropdownField(
                                label: 'Tire Type',
                                value: selectedTireType,
                                onChanged: (v) =>
                                    setState(() => selectedTireType = v),
                                items: [
                                  'Summer',
                                  'Winter',
                                  'Allseason',
                                ],
                              ),
                            ),

                            SizedBox(width: 10),

                            /// Rim Type
                            Flexible(
                              child: DropdownField(
                                label: 'Rim Type',
                                value: selectedRimType,
                                onChanged: (v) =>
                                    setState(() => selectedRimType = v),
                                items: [
                                  'alloy wheels',
                                  'steel wheels',
                                  'standard rims',
                                ],
                              ),
                            ),
                            SizedBox(width: 10),

                             /// has winter package
                            Flexible(
                              child: DropdownField(
                                label: 'Winter Package',
                                value: selectedWinterPackage,
                                onChanged: (v) =>
                                    setState(() => selectedWinterPackage = v),
                                items: [
                                  'Yes',
                                  'No',
                                ],
                              ),
                            ),
                          
                          
                          ],
                        ),
                      )
                       ,
                       
                      /// Damage Information Section
                       Container(

                        padding: EdgeInsets.all( 10),
                        child: Row(
                          children: [

                            /// Damage tire
                            Flexible(
                              child: DropdownField(
                                label: 'Damage Tire',
                                value: selectedTireType,
                                onChanged: (v) =>
                                    setState(() => selectedTireType = v),
                                items: [
                                  'Yes',
                                  'No',
                                  'Unknown',
                                ],
                              ),
                            ),

                            SizedBox(width: 10),

                            /// Damage Rim 
                            Flexible(
                              child: DropdownField(
                                label: 'Damage Rim ',
                                value: selectedRimType,
                                onChanged: (v) =>
                                    setState(() => selectedRimType = v),
                                   items: [
                                  'Yes',
                                  'No',
                                  'Unknown',
                                ],
                              ),
                            ),
                            SizedBox(width: 10),

                             /// tire missing
                            Flexible(
                              child: DropdownField(
                                label: 'Is Tire missing',
                                value: selectedWinterPackage,
                                onChanged: (v) =>
                                    setState(() => selectedWinterPackage = v),
                                items: [
                                  'Yes',
                                  'No',
                                  'Unknown',
                                ],
                              ),
                            ),
                          
                          
                          ],
                        ),
                      
                      )
                       

                      ]
                  ),
                  ),
                  SizedBox(height: 20),


                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Submit logic
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: Text('Danke!'),
                                content: Text(
                                  'Dein Auto wurde erfolgreich eingestellt.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: Navigator.of(ctx).pop,
                                    child: Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFE63946), // Red button
                            padding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: Text(
                            'Predict',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     // Cancel or reset
                      //     setState(() {
                      //       kmController.clear();
                      //       powerController.clear();
                      //       priceController.clear();
                      //     });
                      //   },
                      //   style: ElevatedButton.styleFrom(
                      //     backgroundColor: Colors.white,
                      //     foregroundColor: Color(0xFFE63946),
                      //     side: BorderSide(color: Color(0xFFE63946)),
                      //     padding: EdgeInsets.symmetric(vertical: 12),
                      //   ),

                      //   // child: Row(
                      //   //   mainAxisSize: MainAxisSize.min,
                      //   //   children: [
                      //   //     Icon(Icons.check_circle, size: 16),
                      //   //     SizedBox(width: 5),
                      //   //     Text('Mir ein kostenloses Fahrzeugangebot'),
                      //   //   ],
                      //   // ),

                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// // Custom Widgets
