import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:usecar_ki_system/models/vehicule/damaged_features/damaged_report.dart';
import 'dart:convert';
import '../../models/vehicule/technische_features/tchenic_carlisting.dart' show TechnicCarListing;


class FormApiClient {

  Future<double> submitForm(TechnicCarListing technich, DamageReport damaged ) async {
    final url = Uri.parse('http://localhost:5000/submit_form');

    final bodyData = {
      "technic": technich.toJson(),
      "damaged": damaged.toJson(),
    };
    debugPrint("Sending form data: $bodyData");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(bodyData),
    );
  debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode != 200) {
      throw Exception("Error sending form");
    }

    final result = jsonDecode(response.body);
    return (result["predicted_price"] ?? 0.0).toDouble(); // Preis zurückgeben
  }



  Future<List<dynamic>> fetchCars() async {
  final response = await http.get(Uri.parse('http://localhost:5000/cars')); 
  // Android Emulator benutzt 10.0.2.2 statt localhost

    debugPrint("Response: ${response.statusCode}");

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load cars');
  }
  }
}
