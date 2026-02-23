import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:usecar_ki_system/features/api_client/filter_api.dart';
import 'package:usecar_ki_system/features/recommand_system/main_content.dart';
import 'package:usecar_ki_system/models/car.dart';
import 'package:usecar_ki_system/shared/widgets/custom_appbar.dart';
import 'package:http/http.dart' as http;



class RecommandCarListingPage extends StatefulWidget {
  const RecommandCarListingPage({super.key});

  @override
  _RecommandCarListingPageState createState() =>
      _RecommandCarListingPageState();
}

class _RecommandCarListingPageState extends State<RecommandCarListingPage> {
  late Future<List<Cars>> carsFuture_model;
   late FilterApiClient api;

  @override
  void initState() {
    super.initState();

    api= FilterApiClient();
      _loadCars();
  }

 
  void _loadCars() {
    carsFuture_model = api.fetchRecommendation_model('Doblo cargo');
    // Wenn du sofort die Daten sehen willst:
    carsFuture_model.then((carsList) {
      print('Erstes Auto: ${carsList[0].brand}');

      print('Erstes Auto price: ${carsList[0].engine_power}');

    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHelp: () => print("help"),
        onProfile: () => print("profile"),
      ),
      body: Row(
        children: [
         
          // Hauptbereich
          Expanded(child: MainContent(carsFuture: carsFuture_model )),

        
        ],
      ),
    );
  }

  
}

