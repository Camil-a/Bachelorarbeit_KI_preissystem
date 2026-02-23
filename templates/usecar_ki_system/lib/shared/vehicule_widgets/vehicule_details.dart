

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:usecar_ki_system/models/car_variable.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/vehicule_Form_data_save.dart';
import 'package:usecar_ki_system/shared/widgets/dropdown_field.dart';
import 'package:usecar_ki_system/shared/widgets/number_field.dart';
import 'package:usecar_ki_system/shared/widgets/text_field_with_unit.dart';

class VehicleCard extends StatefulWidget {
   
   final Function( VehiculeFormDataSaved) onChanged;

  const VehicleCard({required this.onChanged, super.key});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  // State variables
 

  int get currentYear => DateTime.now().year;

  @override
  Widget build(BuildContext context) {
    return buildVehicleCard();
  }


  Widget buildVehicleCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 16,
          children: [
                     
              /// Brand and Modell section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: [
                          ///Brand
                          Expanded(
                            child: DropdownField(
                              label: 'Brands',
                              value: selectedBrand,
                              onChanged: (v) {
                                setState(() => selectedBrand = v);
                                 print(selectedBrand);
                              },
                              items: [
                                'Renault',
                                'Ford',
                                'Hyundai',
                                'Fiat',
                                'Opel',
                              ],
                             
                            ),
                          ),


                          /// Model
                          SizedBox(width: 10),
                          Expanded(
                            child: DropdownField(
                              label: 'Model',
                              value: selectedModel,
                              onChanged: (v) {
                                setState(() => selectedModel = v);
                                print(selectedModel);
                              },
                              items: [
                                'Grand Scenic BLUE',
                                'Focus',
                                'Nexo Fuel Cell Sports',
                                'Kango rapid Blue',
                                'Traffic',
                                'Fiesta',
                                'Dablo cargo',
                                'Transit connect',
                                'Tuscson',
                              ],
                            
                            ),
                          ),
                        ],
                      ),

                      /// Power Engine Kw and Horsepower
                      Row(
                        children: [
                          /// Engine Power (kw)
                          Expanded(
                            child: NumberField(
                              label: 'Engine Power(kilowatt)',
                              controller: powerController,
                              unit: 'KW',
                             
                            ),
                          ),

                          SizedBox(width: 10),

                          /// Power Horsepower
                          Expanded(
                            child: NumberField(
                              label: 'Engine Power(Horspower)',
                              controller: horsepowerController,
                              unit: 'PH',
                            
                            ),
                          ),
                        ],
                      ),

                      /// Mileage and transmission type
                      Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Expanded(
                            child: NumberField(
                              controller: mileageController,
                              label: 'Millage',
                              unit: 'km',
                             
                            ),
                          ),

                          SizedBox(width: 10),

                          /// Transmission type
                          Expanded(
                            child: DropdownField(
                              label: 'Transmission type',
                              value: selectedTransmissionType,
                              onChanged: (v) =>
                                  setState(() => selectedTransmissionType = v),
                              items: ['Manuell', 'Automatik'],
                             
                            ),
                          ),
                        ],
                      ),

                      /// Region and Engine Type
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          /// Fuel Type
                          Expanded(
                            child: DropdownField(
                              label: 'Fuel Type',
                              value: selectedEngineType,
                              onChanged: (v) =>
                                  setState(() => selectedEngineType = v),
                              items: ['Diesel', 'Electronic', 'Hydrogen','Benzin'],
                             
                              // isDropdownOnly: false,
                            ),
                          ),

                          SizedBox(width: 10),

                          /// Year of manufacture
                          Expanded(
                            child: DropdownField(
                              label: 'Year of manufactuure',
                              value: selectedYear,
                              onChanged: (v) =>
                                  setState(() => selectedYear = v),
                              items: List.generate(
                                currentYear - 1990 + 1,
                                (i) => (1990 + i).toString(),
                              ),
                              isDropdownOnly: false,
                             
                            ),
                          ),
                        ],
                      ),

                      /// Registration Date
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          /// day of Tuv
                          Expanded(
                            child: DropdownField(
                              label: 'Next TUV: Day',
                              value: selectedDay,
                              onChanged: (v) => setState(() => selectedDay = v),
                              items:
                                  //List.generate(20, (i) => '${2025 + i}')
                                  List.generate(
                                    12,
                                    (i) => (i + 1).toString().padLeft(2, '0'),
                                  ),
                             
                            ),
                          ),

                          /// month of Tuv
                          Expanded(
                            child: DropdownField(
                              label: 'Next TUVMonth',
                              value: selectedTuvMonth,
                              onChanged: (v) =>
                                  setState(() => selectedTuvMonth = v),
                              items: List.generate(
                                12,
                                (i) => (i + 1).toString().padLeft(2, '0'),
                              ),
                            
                            ),
                          ),

                          /// year of first registration
                          Expanded(
                            child: DropdownField(
                              label: 'Next TUV Year',
                              value: selectedTuvYear,
                              onChanged: (v) =>
                                  setState(() => selectedTuvYear = v),
                              items:
                                  // List.generate(
                                  //                       currentYear - 1990 + 1,
                                  //                       (i) => (1990 + i).toString(),
                                  //                     )
                                  List.generate(20, (i) => '${2025 - i}'),
                             
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      ),

                      /// Body Style and number of previous own
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          /// Nber of previous own
                          Expanded(
                            child: TextFieldWithUnit(
                              controller: nberOfPreviousOwn,
                              label: 'Nber of previous own',
                                                         ),
                          ),

                          /// Body Style
                          Expanded(
                            child: DropdownField(
                              label: 'Body Style',
                              value: selectedBodyStyle,
                              onChanged: (v) =>
                                  setState(() => selectedBodyStyle = v),
                              items: [
                                'van/Minivan',
                                'Kombilimousine',
                                'Limousine',
                                'Cabrio',
                                'transporter',
                                'Van',
                                'Kombi',
                              ],
                             
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// Accident History
                          Expanded(
                            child: DropdownField(
                              label: 'Accident history?',
                              value: selectedAccidentHistory,
                              onChanged: (v) =>
                                  setState(() => selectedAccidentHistory = v),
                              items: ['Yes', 'No'],
                             
                              // isDropdownOnly: false,
                            ),
                          ),

                          /// Tire Type
                          Expanded(
                            child: DropdownField(
                              label: 'Tire Type',
                              value: selectedTireType,
                              onChanged: (v) =>
                                  setState(() => selectedTireType = v),
                              items: ['Summer', 'Winter', 'Allseason'],
                            
                            ),
                          ),
                        
                        ],
                      ),


          ],
        ),
      ),
    );
  }


}