import 'package:flutter/material.dart';

Color indicatorColor(num? value) {
  return (value ?? 0) > 0 ? Colors.green : Colors.red;
}
