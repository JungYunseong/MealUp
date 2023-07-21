import 'package:flutter/material.dart';

class DisplayWeight extends StatelessWidget {
  const DisplayWeight({
    super.key,
    required this.label,
    required this.weight,
  });

  final String label;
  final int weight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFE3DEFF),
            fontSize: 12,
            fontFamily: 'Noto Sans KR',
            fontWeight: FontWeight.w500,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10.0),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: weight.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(
                text: ' kg',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Rubik',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.20,
                ),
              ),
            ],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
