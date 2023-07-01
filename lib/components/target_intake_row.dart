import 'package:flutter/material.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:provider/provider.dart';

import '../providers/setting_provider.dart';

class TargetIntakeRow extends StatefulWidget {
  const TargetIntakeRow({
    super.key,
    required this.nutrition,
    required this.currentIntake,
    this.isEditScreen = false,
  });

  final Nutrition nutrition;
  final int currentIntake;
  final bool isEditScreen;

  @override
  State<TargetIntakeRow> createState() => _TargetIntakeRowState();
}

class _TargetIntakeRowState extends State<TargetIntakeRow> {
  int goalIntake = 1;

  @override
  void initState() {
    setState(() {
      switch (widget.nutrition) {
        case Nutrition.carbohydrate:
          goalIntake = context.read<Setting>().goalCarbohydrate!;
        case Nutrition.protein:
          goalIntake = context.read<Setting>().goalProtein!;
        case Nutrition.fat:
          goalIntake = context.read<Setting>().goalFat!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    color: widget.nutrition.getColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  widget.nutrition.convertToString,
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
            '${widget.currentIntake.toString()}g',
            style: const TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.20,
            ),
          ),
          if (!widget.isEditScreen)
            Text(
              '${(widget.currentIntake / goalIntake * 100).round()}%',
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
