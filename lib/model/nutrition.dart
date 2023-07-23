import 'package:flutter/material.dart';

enum Nutrition {
  carbohydrate,
  protein,
  fat,
}

extension NutritionExtension on Nutrition {
  String get convertToString {
    switch (this) {
      case Nutrition.carbohydrate:
        return '탄수화물';
      case Nutrition.protein:
        return '단백질';
      case Nutrition.fat:
        return '지방';
    }
  }

  Color get getColor {
    switch (this) {
      case Nutrition.carbohydrate:
        return const Color(0xFF1F87FE);
      case Nutrition.protein:
        return const Color(0xFF7265E3);
      case Nutrition.fat:
        return const Color(0xFF7FE3F0);
    }
  }
}
