import 'package:flutter/cupertino.dart';

import '../model/nutrition.dart';
import 'add_food_text_field.dart';

class NutritionTextField extends StatelessWidget {
  const NutritionTextField({
    super.key,
    required this.nutrition,
    required this.controller,
    required this.onChanged,
  });

  final Nutrition nutrition;
  final TextEditingController controller;
  final Function(String value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 90.0,
            child: Row(
              children: [
                Container(
                  width: 13.95,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: nutrition.getColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  nutrition.convertToString,
                  style: const TextStyle(
                    color: Color(0xFF2D3142),
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.23,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 90.0,
            child: AddFoodTextField(
              controller: controller,
              inputType: TextInputType.number,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8.0),
          const Text(
            'g',
            style: TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.23,
            ),
          )
        ],
      ),
    );
  }
}
