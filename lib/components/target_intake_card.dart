import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_up/components/target_intake_row.dart';
import 'package:meal_up/model/chart_data.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TargetIntake extends StatefulWidget {
  const TargetIntake({
    super.key,
    required this.selectedValue,
  });

  final DateTime selectedValue;

  @override
  State<TargetIntake> createState() => _TargetIntakeState();
}

class _TargetIntakeState extends State<TargetIntake> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x266F88D1),
            blurRadius: 30,
            offset: Offset(0, 10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 28.0, 28.0, 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '목표 섭취량',
                      style: TextStyle(
                        color: Color(0xFF2D3142),
                        fontSize: 20,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      DateFormat('yyyy년 MM월 dd일').format(
                        widget.selectedValue,
                      ),
                      style: const TextStyle(
                        color: Color(0xFF2D3142),
                        fontSize: 13,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                CupertinoButton(
                  padding: EdgeInsets.zero,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE4DFFF),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        CupertinoIcons.pencil,
                        color: Color(0xFF7265E3),
                        size: 24.0,
                      ),
                    ),
                  ),
                  onPressed: () {
                    print('편집');
                  },
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Stack(
              alignment: Alignment.center,
              children: [
                SfCircularChart(series: _getRadialBarCustomizedSeries()),
                const Column(
                  children: [
                    Text(
                      '40%',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF2D3142),
                        fontSize: 32,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'of daily goals',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF4C5980),
                        fontSize: 14,
                        fontFamily: 'Rubik',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const TargetIntakeRow(
              nutrition: Nutrition.carbohydrate,
              currentIntake: 100,
            ),
            const TargetIntakeRow(
              nutrition: Nutrition.protein,
              currentIntake: 80,
            ),
            const TargetIntakeRow(
              nutrition: Nutrition.fat,
              currentIntake: 100,
            ),
          ],
        ),
      ),
    );
  }

  List<RadialBarSeries<ChartData, String>> _getRadialBarCustomizedSeries() {
    return <RadialBarSeries<ChartData, String>>[
      RadialBarSeries<ChartData, String>(
        animationDuration: 0,
        maximumValue: 100,
        gap: '5%',
        radius: '100%',
        dataSource: <ChartData>[
          ChartData(
            x: 'Fat',
            y: 62.70,
            pointColor: const Color(0xFF7FE3F0),
          ),
          ChartData(
            x: 'Protein',
            y: 29.20,
            pointColor: const Color(0xFFAF8EFF),
          ),
          ChartData(
            x: 'Carbohydrate',
            y: 85.20,
            pointColor: const Color(0xFF1F87FE),
          ),
        ],
        cornerStyle: CornerStyle.bothCurve,
        xValueMapper: (ChartData data, _) => data.x,
        yValueMapper: (ChartData data, _) => data.y,
        pointColorMapper: (ChartData data, _) => data.pointColor,
      ),
    ];
  }
}
