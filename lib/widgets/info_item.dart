import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InfoItem extends StatelessWidget {
  InfoItem({required this.title,required this.value});
  String title;
  String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 15, color: Colors.grey),
          )
        ],
      ),
    );
  }
}
