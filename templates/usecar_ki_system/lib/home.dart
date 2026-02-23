import 'package:flutter/material.dart';
import 'package:usecar_ki_system/features/api_client/form_api_client.dart';
import 'package:usecar_ki_system/models/car_variable.dart';
import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_form_data_save.dart';
import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_report.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/tchenic_carlisting.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/vehicule_Form_data_save.dart';
import 'package:usecar_ki_system/routes/app_route_name.dart';
import 'package:usecar_ki_system/shared/vehicule_widgets/damaged_report.dart';
import 'package:usecar_ki_system/shared/vehicule_widgets/vehicule_details.dart';
import '../shared/widgets/nav_link.dart';


class CarSalesFormPages extends StatefulWidget {
  const CarSalesFormPages({super.key});

  @override
  State<CarSalesFormPages> createState() => _CarSalesFormPageState();
}

class _CarSalesFormPageState extends State<CarSalesFormPages> {
  final _formKey = GlobalKey<FormState>();


  final int currentYear = DateTime.now().year;

  double? predictedPrice;
  VehiculeFormDataSaved vehiculeDataSave = VehiculeFormDataSaved();
  DamagedFormDataSave damagedDataSave = DamagedFormDataSave();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/logo_sfm.png', height: 36),
            Spacer(),

            Flexible(child:NavLink(label: 'Predict Use Case', routeName: predictCarRouterName),
            ),
            SizedBox(width: 16),
            Flexible(child:NavLink(label: 'Car Recommendation', routeName: recommandRouterName),
            ) ,
          ],
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 16,
            children: [

              ///Title
               Text(
                        'Vehicule Details',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              const SizedBox(height: 16),

              /// Vehicle Details
               VehicleCard(
                 onChanged: (updatedData) {
                   setState(() {
                     vehiculeDataSave = updatedData;
                   });
                 },
               ),
              //const SizedBox(height: 16),

              /// Title
              Text( 'Damages Report',
                       style: TextStyle(fontWeight: FontWeight.bold),
                      ),
             // const SizedBox(height: 16),

              /// Damage Report
              DamagedReportPage(
                onChanged: (updatedData) {
                  setState(() {
                    damagedDataSave = updatedData;
                  });
                },
              ),
              //const SizedBox(height: 16),

              /// Predict Button + Result
                 buildPredictButton(),


             /// Result Card
              if (predictedPrice != null) buildResultCard(),
            ],
          ),
        ),
      ),
    );
  }

  // PREDICT BUTTON
  // =========================================================
  Widget buildPredictButton() {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFE63946),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: _predictPrice,
        child: const Text("Predict Price"),
      ),
    );
  }

  // RESULT CARD
  // =========================================================
  Widget buildResultCard() {
    return Card(
      color: Colors.green.shade50,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text("Predicted Price"),
            const SizedBox(height: 6),
            Text(
              "€ ${predictedPrice!.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // API CALL
  // =========================================================
  Future<void> _predictPrice() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
        print('variable::::::');
     // prepare data to send to API
                             
  try {
                              // prepare data to send to API
                              final carData = TechnicCarListing(
                                brand: selectedBrand ?? '',
                                model: selectedModel ?? '',
                                year: selectedYear ?? '',
                                enginePowerPs:
                                    int.tryParse(powerController.text) ?? 0,
                                enginePowerHs:
                                    int.tryParse(powerController.text) ?? 0,
                                mileage:
                                    double.tryParse(mileageController.text) ??
                                    0,
                                engineType: selectedEngineType ?? ' ',
                                nextTuvYear: selectedTuvYear ?? '',
                                nextTuvMonate:
                                    selectedTuvMonth ?? '', // November
                                nextTuvDay: selectedDay ?? '',
                                nberPreviousOwners:
                                    selectedNberPreviousOwners ?? '',
                                bodyStyle: selectedBodyStyle ?? '',
                                transmissionType:
                                    selectedTransmissionType ?? '',
                                tireType: selectedTireType ?? '',
                                accidentHistory: selectedAccidentHistory ?? '',
                              );

                              // Damage Report data
                              final damaged = DamageReport(
                                damagedFront: selectedDamagedFront == 'Yes'
                                    ? 1
                                    : 0,
                                damagedRear: selectedDamagedRear == 'Yes'
                                    ? 1
                                    : 0,
                                damagedLeftSide:
                                    selectedDamagedLeftSide == 'Yes' ? 1 : 0,
                                damagedRightSide:
                                    selectedDamagedRightSide == 'Yes' ? 1 : 0,
                                damagedInterior:
                                    selectedDamagedInterior == 'Yes' ? 1 : 0,
                                damagedExterior:
                                    selectedDamagedExterior == 'Yes' ? 1 : 0,
                                damagedTire: selectedDamageTire == 'Yes'
                                    ? 1
                                    : 0,
                                damagedRim: selectedDamageRim == 'Yes' ? 1 : 0,
                                damagedRoofBeam:
                                    selectedDamagedRoofBeam == 'Yes' ? 1 : 0,
                                damagedLeftDoor:
                                    selectedDamagedLeftDoor == 'Yes' ? 1 : 0,
                                damagedRightDoor:
                                    selectedDamagedRightDoor == 'Yes' ? 1 : 0,
                                damagedSeats: selectedDamagedSeats == 'Yes'
                                    ? 1
                                    : 0,
                                interiorDirty: selectedInteriorDirty == 'Yes'
                                    ? 1
                                    : 0,
                                damagedCarosserie:
                                    selectedDamagedCarosserie == 'Yes' ? 1 : 0,
                              );

                              /// result to price predict
                              final result = await FormApiClient().submitForm(
                                carData,
                                damaged
                              ); // send to python

                              setState(() {
                                predictedPrice = result;
                              });
                            } catch (e) {
                              print("FEHLER: $e");
                            }
                          }

   
}
