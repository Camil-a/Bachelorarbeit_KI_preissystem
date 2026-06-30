import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:usecar_ki_system/models/car.dart';




class FilterApiClient {

 Future<List<Cars>> fetchRecommendationModel(String model) async {

  final url = 'http://localhost:5001/recommend?model=$model';
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



 Future<List<Cars>> fetchSearch(String query) async {
  final url = 'http://localhost:5001/search?q=${Uri.encodeComponent(query)}';
  debugPrint("Request URL: $url");

  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((e) => Cars.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load search results');
  }
}


 Future<List<Cars>> fetchRecommendationPrice(double price) async {

  final url = 'http://localhost:5001/recommend_price?sale_price=$price';
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
