
import 'package:flutter/material.dart';

class InfoBox extends StatelessWidget {
  final String title;
  final String content;

  // ignore: use_super_parameters
  const InfoBox({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFCCE5FF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue, size: 18),
              SizedBox(width: 8),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
            ],
          ),
          SizedBox(height: 8),
          Text(content, style: TextStyle(fontSize: 12, color: Colors.blue[800])),
        ],
      ),
    );
  }
}