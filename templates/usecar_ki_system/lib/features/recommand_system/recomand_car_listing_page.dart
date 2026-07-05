import 'package:flutter/material.dart';
import 'package:usecar_ki_system/features/api_client/filter_api.dart';
import 'package:usecar_ki_system/features/recommand_system/main_content.dart';
import 'package:usecar_ki_system/models/car.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/vehicule_Form_data_save.dart';
import 'package:usecar_ki_system/shared/widgets/custom_appbar.dart';

class RecommandCarListingPage extends StatefulWidget {
  const RecommandCarListingPage({super.key});

  @override
  State<RecommandCarListingPage> createState() =>
      _RecommandCarListingPageState();
}

class _RecommandCarListingPageState extends State<RecommandCarListingPage> {
  late Future<List<Cars>> currentCarsFuture;
  late FilterApiClient api;

  String? selectedModel;
  double? selectedPrice;
  double? selectedMileage;
  CarDataSaved vehiculeDataSave = CarDataSaved();

  @override
  void initState() {
    super.initState();
    api = FilterApiClient();
    currentCarsFuture = api.fetchRecommendationPrice(3000);
    
  }

  void _onFilterChanged(CarDataSaved data) {
    setState(() {
      selectedModel = data.model;
      selectedPrice = data.price;
      selectedMileage = data.mileage;

      if (data.searchQuery != null && data.searchQuery!.isNotEmpty) {
        currentCarsFuture = api.fetchSearch(data.searchQuery!);
      } else if (selectedModel != null) {
        selectedPrice = null;
        currentCarsFuture = api.fetchRecommendationModel(selectedModel!);
      } else if (selectedPrice != null) {
        selectedModel = null;
        currentCarsFuture = api.fetchRecommendationPrice(selectedPrice!);
      } else {
        currentCarsFuture = api.fetchRecommendationPrice(3000);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onHelp: () {},
        onProfile: () {},
      ),
      body: Row(
        children: [
          Expanded(
            child: MainContent(
              carsFuture: currentCarsFuture,
              onFilterChanged: _onFilterChanged,
            ),
          ),
        ],
      ),
    );
  }
}
