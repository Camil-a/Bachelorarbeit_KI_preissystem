
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car.dart';
import 'package:usecar_ki_system/models/vehicule/technische_features/vehicule_Form_data_save.dart';
import 'package:usecar_ki_system/shared/widgets/card_card.dart';
import 'package:usecar_ki_system/shared/widgets/dropdown_field.dart';
import 'package:usecar_ki_system/shared/constants/colors.dart';
import 'package:usecar_ki_system/shared/constants/sizes.dart';



class MainContent extends StatefulWidget {
  final Future<List<Cars>> carsFuture;
  final Function(CarDataSaved) onFilterChanged;


  const MainContent({super.key, required this.carsFuture,
  required this.onFilterChanged
   });

  @override
  _MainContentState createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {
  String selectedValue = 'Model';
  TextEditingController priceController = TextEditingController();
  TextEditingController mileageController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  String? selectedModel;

  @override
  void dispose() {
    priceController.dispose();
    mileageController.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _sendFilter() {
    CarDataSaved data = CarDataSaved();
    if (selectedValue == 'Model') {
      data.model = selectedModel;
    } else if (selectedValue == 'Price') {
      data.price = double.tryParse(priceController.text);
    }
    widget.onFilterChanged(data);
  }

  void _onSearchSubmit() {
    final input = searchController.text.trim();
    if (input.isEmpty) return;

    // Remove currency symbol and spaces, then try to parse as a number (price)
    final cleaned = input.replaceAll('€', '').replaceAll(' ', '');
    final asPrice = double.tryParse(cleaned);

    final data = CarDataSaved();
    if (asPrice != null) {
      data.price = asPrice;
    } else {
      data.searchQuery = input;
    }
    widget.onFilterChanged(data);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// search bar to describe the car you are looking for
    
              _buildSearchBar(),
              SizedBox(height: 16),

               _buildSortAndSave(),
               SizedBox(height: 16),


        /// car list
         Expanded(
           child:   
           _buildCarList()
      ),
      ],
    );
  }

 Widget _buildCarList() {

  
    return FutureBuilder<List<Cars>>(
      future: widget.carsFuture,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {

          return const Center(child: CircularProgressIndicator());

        } else if (snapshot.hasError) {

          return Center(child: Text('Error: ${snapshot.error}'));

        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {

          return const Center(child: Text('Keine Autos gefunden'));
          
        } else {
          final cars = snapshot.data!;
          return ListView.builder(
            itemCount: cars.length,
            itemBuilder: (context, index) {
              return CarCard(car: cars[index]); // dynamisch
            },
          );
        }
      }, 
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        controller: searchController,
        onSubmitted: (_) => _onSearchSubmit(),
        decoration: InputDecoration(
          hintText: 'Beschreiben Sie, welches Auto Sie suchen (Modell, Marke, Preis)',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: _onSearchSubmit,
          ),
          filled: true,
          fillColor: AppColors.inputFill,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Sizes.radiusSearch),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
 



 Widget _buildSortAndSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

        children: [
           
            DropdownButtonFormField<String>(
             hint: const Text("Select a sort option"),
              value: selectedValue,
              items:const [
                DropdownMenuItem( value: 'Price',child: Text('Price'), ),
                DropdownMenuItem( value: 'Mileage',child: Text('Mileage'), ),
                DropdownMenuItem( value: 'Model', child: Text('Model'), ),
              ],
              
             onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                     _sendFilter();

                  },

              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Sizes.radiusSmall),
                ),
              ),
            ),
         

           
  
            const SizedBox(height: 12),

    if (selectedValue == 'Price') 

          SizedBox(
            width: double.infinity,
            child:   TextField(
            controller: priceController,
            keyboardType: TextInputType.number,

            decoration: InputDecoration(
              labelText: "Enter Price",
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  _sendFilter();
                },
              ),
            ),
                 
                  ),
            ),

             if (selectedValue== 'Mileage')
          TextField(
            controller: mileageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Mileage (km)',
              border: OutlineInputBorder(),
            ),
              onChanged: (value) {
              _sendFilter();
                }

          ),  
            if (selectedValue== 'Model')

             DropdownField(
                              label: 'Choise the model',
                              value: selectedModel,
                              onChanged: (value) {
                                setState(() => selectedModel = value);
                                _sendFilter();
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

        ],
      ),
    );
  }
   
}
  
  


