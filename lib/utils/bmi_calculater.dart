import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';

double calculateBMI({required int height, required double weight}) {
  final mHeight = height / 100;
  final bmi = weight / (mHeight * mHeight);
  return bmi;
}

Color getBMIBackgroundColor(int bmi) {
  Color backgroundColor = const Color(0xFFD8EDFF);
  if (bmi < 18.5) {
    backgroundColor = const Color(0xFFD8EDFF);
  } else if (bmi < 23) {
    backgroundColor = const Color(0xFF007ACC);
  } else if (bmi < 25) {
    backgroundColor = const Color(0xFFFFCC00);
  } else if (bmi < 30) {
    backgroundColor = const Color(0xFFFF9900);
  } else if (bmi < 35) {
    backgroundColor = const Color(0xFFFF6600);
  } else {
    backgroundColor = const Color(0xFFFF3300);
  }
  return backgroundColor;
}

Color getBMIForegroundColor(int bmi) {
  Color foregroundColor = Colors.white;

  if ((bmi < 18.5) || (23 <= bmi && bmi < 25)) {
    foregroundColor = primaryTextColor;
  }

  return foregroundColor;
}

String getBMIDescription({required int height, required double weight}) {
  final mHeight = height / 100;
  final minWeight = (18.5 * mHeight * mHeight).round();
  final maxWeight = (22.9 * mHeight * mHeight).round();

  String upDown = '낮';
  String result =
      '체중이 정상 범위보다 $upDown습니다.\n$minWeight - $maxWeight kg 사이를 권장합니다.';

  if (weight >= minWeight && weight <= maxWeight) {
    result = '체중이 정상범위 내에 있습니다!\n계속해서 균형 잡힌 식사를 해주세요.';
  } else if (weight > minWeight) {
    upDown = '높';
  }

  return result;
}
