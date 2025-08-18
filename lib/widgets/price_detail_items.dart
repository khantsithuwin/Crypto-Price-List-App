import 'package:flutter/material.dart';

class PriceDetailItems extends StatelessWidget {
  const PriceDetailItems({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(title), subtitle: Text(value));
  }
}
