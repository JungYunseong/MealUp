import 'package:flutter/material.dart';

class BMICard extends StatelessWidget {
  const BMICard({super.key, required this.bmi});

  final int bmi;

  @override
  Widget build(BuildContext context) {
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
              color: const Color(0xFFFF9B90),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'BMI',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: 'Rubik',
                      fontWeight: FontWeight.w400,
                      height: 1.0,
                      letterSpacing: 0.17,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    bmi.toString(),
                    style: const TextStyle(
                      color: Colors.white,
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
          const Text(
            'Your weight is under normal.\nSuggested range is 80-90kg',
            style: TextStyle(
              color: Color(0xFF4C5980),
              fontSize: 14,
              fontFamily: 'Rubik',
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
