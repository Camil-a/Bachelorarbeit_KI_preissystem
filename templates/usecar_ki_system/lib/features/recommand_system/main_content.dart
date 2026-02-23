
import 'package:flutter/material.dart';
import 'package:usecar_ki_system/models/car.dart';
import 'package:usecar_ki_system/shared/widgets/card_card.dart';



class MainContent extends StatelessWidget {
  //String _selectedSort = 'price';
  //final Future<List<dynamic>> carsFuture_model;
    final Future<List<Cars>> carsFuture;


  const MainContent({super.key, required this.carsFuture});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [

        /// search bar to describe the car you are looking for
        
      //     Expanded(
      //      child:
      //   _buildSearchBar()

      //     ),
              
         

      //  // _buildSortAndSave(),
      //    Expanded(
      //      child: _buildSortAndSave()
      //       ),
              _buildSearchBar(),
                _buildSortAndSave(),

        /// car list
        //_buildCarList(),

         Expanded(
           child:   
           _buildCarList()
      ),
      ],
    );
  }

 Widget _buildCarList() {
    return FutureBuilder<List<Cars>>(
      future: carsFuture,
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
/// search bar to describe the car you are looking for
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Beschreibe, welches Auto du suchst',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {},
          ),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
 
 Widget _buildSortAndSave() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: DropdownButtonFormField<String>(
              value: 'Price',
              items: [
                DropdownMenuItem(
                  value: 'Price',
                  child: Text(' Price'),
                ),
                DropdownMenuItem(
                  value: 'Mileage',
                  child: Text(' Mileage'),
                ),
                DropdownMenuItem(
                value: 'Model',
                child: Text('Model'),
              ),

              
                // Weitere Sortieroptionen...
              ],
              onChanged: (_) {},
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
         
        ],
      ),
    );
  }


  // Widget _buildCarList() {
  //   return Expanded(
    
  //     child: ListView(
  //       children: [
  //         CarCard(car: car),
  //       ],
  //     ),
  //   );
  // }

   
}
  
  


