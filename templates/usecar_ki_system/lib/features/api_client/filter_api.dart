import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:usecar_ki_system/models/car.dart';




class FilterApiClient {

 Future<List<Cars>> fetchRecommendation_model(String model) async {

  final url = 'http://localhost:5000/recommend?model=$model';
  print("Request URL: $url");

  final response = await http.get(Uri.parse(url));

  print("Status ${response.statusCode}");
 // print("Body ........................ ${response.body}");

  if (response.statusCode == 200) {
    List data = json.decode(response.body);
    return data.map((e) => Cars.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load recommendations');
  }
}
}


