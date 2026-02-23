import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car_variable.dart';
import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_form_data_save.dart';

class DamagedReportPage extends StatefulWidget {

  final Function(DamagedFormDataSave)? onChanged;

  const DamagedReportPage({super.key, this.onChanged});

  @override
  _DamagedReportPageState createState() => _DamagedReportPageState();
}

class _DamagedReportPageState extends State<DamagedReportPage> {
 
  @override
  Widget build(BuildContext context) {
    return buildDamagedCard();
  }
  

  Widget buildDamagedCard() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
         // crossAxisCount: 2,
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 1 : 2,

          shrinkWrap: true,
          physics: const  NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: MediaQuery.of(context).size.width < 600 ? 8 : 9,

          children: [
              // Titles
           
            buildDamageDropdown("Is Front damaged?", (v) => selectedDamagedFront = v),
            buildDamageDropdown("Is Rear damaged?", (v) => selectedDamagedRear = v),
            buildDamageDropdown("Left Side damaged?", (v) => selectedDamagedLeftSide = v),
            buildDamageDropdown("Right Side damaged?", (v) => selectedDamagedRightSide = v),
            buildDamageDropdown("Interior damaged?", (v) => selectedDamagedInterior = v),
            buildDamageDropdown("Interior dirty?", (v) => selectedInteriorDirty = v),
            buildDamageDropdown("Roof Beam damaged?", (v) => selectedDamagedRoofBeam = v),
            buildDamageDropdown("Seats damaged?", (v) => selectedDamagedSeats = v),
            buildDamageDropdown("Left Door damaged?", (v) => selectedDamagedLeftDoor = v),
            buildDamageDropdown("Right Door damaged?", (v) => selectedDamagedRightDoor = v),
            buildDamageDropdown("Carosserie damaged?", (v) => selectedDamagedCarosserie = v),
            buildDamageDropdown("Exterior damaged?", (v) => selectedDamagedExterior = v),
            buildDamageDropdown("Rim damaged?", (v) => selectedDamagedRim = v),
            buildDamageDropdown("Tire damaged?", (v) => selectedDamagedTire = v),
          ],
        ),
      ),
    );
  }

  Widget buildDamageDropdown(String label, Function(String?) setter) {
          double fontSize = MediaQuery.of(context).size.width < 600 ? 14 : 18;


    return DropdownButtonFormField<String>(
        isExpanded: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
        fontSize: fontSize,       // Schriftgröße für das Label
        fontWeight: FontWeight.w100, // optional fett
      ),
        //filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      items: ['Yes', 'No']
          .map((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),
      onChanged: (v) => setState(() => setter(v)),
      value: null,
    );
  }

  
  }
