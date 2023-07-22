import 'package:flutter/material.dart';
import 'package:meal_up/providers/setting_provider.dart';
import 'package:meal_up/utils/bmi_calculater.dart';
import 'package:provider/provider.dart';

class BMICard extends StatefulWidget {
  const BMICard({super.key, required this.currentWeight});

  final double currentWeight;

  @override
  State<BMICard> createState() => _BMICardState();
}

class _BMICardState extends State<BMICard> {
  int bmi = 20;

  @override
  Widget build(BuildContext context) {
    bmi = calculateBMI(
      height: context.watch<Setting>().height!,
      weight: widget.currentWeight,
    ).round();

    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: ShapeDecoration(
        color: const Color(0xFFF4F6FA),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: ShapeDecoration(
              color: getBMIBackgroundColor(bmi),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'BMI',
                    style: TextStyle(
                      color: getBMIForegroundColor(bmi),
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0.17,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    bmi.round().toString(),
                    style: TextStyle(
                      color: getBMIForegroundColor(bmi),
                      fontSize: 20,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w500,
                      height: 1.0,
                      letterSpacing: 0.22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16.0),
          Text(
            getBMIDescription(
              height: context.watch<Setting>().height!,
              weight: widget.currentWeight,
            ),
            style: const TextStyle(
              color: Color(0xFF4C5980),
              fontSize: 14,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.20,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}
