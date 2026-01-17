
import 'package:flutter/material.dart';

// ignore: unused_element
class _SearchBox extends StatelessWidget {
@override
Widget build(BuildContext context) {
return Padding(
padding: const EdgeInsets.symmetric(horizontal: 20),
child: TextField(
decoration: InputDecoration(
hintText: 'VW ID.4 bis 35.000 € und 50.000 km',
filled: true,
fillColor: Colors.white,
prefixIcon: const Icon(Icons.search),
border: OutlineInputBorder(
borderRadius: BorderRadius.circular(12),
borderSide: BorderSide.none,
),
),
),
);
}
}