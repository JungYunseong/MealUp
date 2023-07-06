import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/display_weight.dart';

import '../constant.dart';

class RecentStatusScreen extends StatefulWidget {
  const RecentStatusScreen({super.key});

  @override
  State<RecentStatusScreen> createState() => _RecentStatusScreenState();
}

class _RecentStatusScreenState extends State<RecentStatusScreen> {
  int currentWeight = 90;
  int goalWeight = 80;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '현황',
          style: navTitle,
        ),
        const SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DisplayWeight(label: '현재', weight: currentWeight),
            Image.asset(
              'assets/icons/weight.png',
              width: 24.0,
              fit: BoxFit.fitWidth,
            ),
            DisplayWeight(label: '목표', weight: goalWeight),
          ],
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(24),
              ),
              color: Color(0xFFF4F6FA),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 27.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My progress',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 20,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        child: Container(
                          padding:
                              const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                          height: 40,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFE3DEFF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Text(
                                'Weekly',
                                style: TextStyle(
                                  color: Color(0xFF7265E3),
                                  fontSize: 12,
                                  fontFamily: 'Rubik',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.20,
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Image.asset(
                                'assets/icons/dropdown.png',
                                width: 10.0,
                                fit: BoxFit.fitWidth,
                              )
                            ],
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 500.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
