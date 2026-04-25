import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:usecar_ki_system/models/car.dart';




class FilterApiClient {

 Future<List<Cars>> fetchRecommendation_model(String model) async {

  final url = 'http://localhost:5000/recommend?model=$model';
  debugPrint("Request URL: $url");

  final response = await http.get(Uri.parse(url));

  //debugPrint("Status ${response.statusCode}");
 // debugPrint("Body ........................ ${response.body}");

  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((e) => Cars.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load recommendations');
  }
}



 Future<List<Cars>> fetchRecommendation_price(double price) async {

  final url = 'http://localhost:5000/recommend_price?sale_price=$price';
  debugPrint("Request URL: $url");

  final response = await http.get(Uri.parse(url));

  debugPrint("Status----price ${response.statusCode}");
 // debugPrint("Body ........................ ${response.body}");

  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((e) => Cars.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load recommendations');
  }
}

}
