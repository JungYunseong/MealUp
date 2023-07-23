import 'package:flutter/material.dart';

class ChartData {
  final String x;
  final double y;
  final String? text;
  final Color pointColor;

  ChartData({
    required this.x,
    required this.y,
    this.text,
    required this.pointColor,
  });
}
