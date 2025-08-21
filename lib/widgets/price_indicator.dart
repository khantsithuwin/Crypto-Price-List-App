import 'package:crypto_price_list/const/indicator_color.dart';
import 'package:flutter/material.dart';

Widget priceIndicator(num? value) {
  return (value ?? 0) > 0
      ? Icon(Icons.arrow_drop_up, color: indicatorColor(value))
      : Icon(Icons.arrow_drop_down, color: indicatorColor(value ?? 0.0));
}
