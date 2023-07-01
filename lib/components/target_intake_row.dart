import 'package:flutter/material.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:provider/provider.dart';

import '../providers/setting_provider.dart';

class TargetIntakeRow extends StatelessWidget {
  const TargetIntakeRow({
    super.key,
    required this.nutrition,
    required this.currentIntake,
  });

  final Nutrition nutrition;
  final int currentIntake;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                )
              ],
            ),
          ),
          Text(
            '${currentIntake.toString()}g',
            style: const TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.20,
            ),
          ),
          Text(
            '${(currentIntake / context.read<Setting>().goalCarbohydrate! * 100).round()}%',
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w500,
              letterSpacing: 0.20,
            ),
          ),
        ],
      ),
    );
  }
}
