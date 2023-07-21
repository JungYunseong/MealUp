import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/display_weight.dart';
import 'package:meal_up/components/weight_chart.dart';
import 'package:pull_down_button/pull_down_button.dart';
import '../components/bmi_card.dart';
import '../constant.dart';

class RecentStatusScreen extends StatefulWidget {
  const RecentStatusScreen({super.key});

  @override
  State<RecentStatusScreen> createState() => _RecentStatusScreenState();
}

class _RecentStatusScreenState extends State<RecentStatusScreen> {
  String graphType = 'Weekly';

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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              color: Colors.white,
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              shrinkWrap: true,
              children: [
                const SizedBox(height: 27.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      '나의 현황',
                      style: TextStyle(
                        color: Color(0xFF2D3142),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    PullDownButton(
                      itemBuilder: (context) {
                        return [
                          PullDownMenuItem.selectable(
                            onTap: () {
                              setState(() {
                                graphType = 'Weekly';
                              });
                            },
                            title: 'Weekly',
                          ),
                          PullDownMenuItem.selectable(
                            onTap: () {
                              setState(() {
                                graphType = 'Monthly';
                              });
                            },
                            title: 'Monthly',
                          ),
                        ];
                      },
                      buttonBuilder: (context, showMenu) => CupertinoButton(
                        onPressed: showMenu,
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
                              Text(
                                graphType,
                                style: const TextStyle(
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24.0),
                const WeightChart(),
                const SizedBox(height: 40.0),
                const BMICard(bmi: 25),
                const SizedBox(height: 56.0),
                const Text(
                  '최근 현황',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.32,
                  ),
                ),
                const SizedBox(height: 24.0),
                SafeArea(
                  child: CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () {},
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          '체중 업데이트',
                          style: buttonText,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
