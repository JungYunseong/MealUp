import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_up/components/target_intake_row.dart';
import 'package:meal_up/model/chart_data.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:meal_up/screens/edit_goal_screen.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../providers/setting_provider.dart';

class TargetIntake extends StatefulWidget {
  const TargetIntake({
    super.key,
    required this.selectedDate,
    required this.carbIntake,
    required this.proteinIntake,
    required this.fatIntake,
    required this.onDismiss,
  });

  final DateTime selectedDate;
  final int carbIntake;
  final int proteinIntake;
  final int fatIntake;
  final Function onDismiss;

  @override
  State<TargetIntake> createState() => _TargetIntakeState();
}

class _TargetIntakeState extends State<TargetIntake> {
  int totalPercent = 0;
  double carbPercent = 0.0;
  double proteinPercent = 0.0;
  double fatPercent = 0.0;

  void calculatePercent() {
    setState(() {});
    carbPercent = (widget.carbIntake /
                context.read<Setting>().goalCarbohydrate! *
                100) >=
            100
        ? 100
        : (widget.carbIntake / context.read<Setting>().goalCarbohydrate! * 100);
    proteinPercent = (widget.proteinIntake /
                context.read<Setting>().goalProtein! *
                100) >=
            100
        ? 100
        : (widget.proteinIntake / context.read<Setting>().goalProtein! * 100);
    fatPercent =
        (widget.fatIntake / context.read<Setting>().goalFat! * 100) >= 100
            ? 100
            : (widget.fatIntake / context.read<Setting>().goalFat! * 100);

    totalPercent = ((carbPercent + proteinPercent + fatPercent) / 3).round();
  }

  @override
  Widget build(BuildContext context) {
    calculatePercent();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Container(
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          widget.selectedDate,
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
                      Navigator.pushNamed(
                        context,
                        EditGoalScreen.routeName,
                        arguments:
                            EditGoalScreenArguments(() => widget.onDismiss()),
                      );
                    },
                  )
                ],
              ),
              const SizedBox(height: 20.0),
              Stack(
                alignment: Alignment.center,
                children: [
                  SfCircularChart(series: _getRadialBarCustomizedSeries()),
                  Column(
                    children: [
                      Text(
                        '${totalPercent.toString()}%',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 32,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
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
              TargetIntakeRow(
                nutrition: Nutrition.carbohydrate,
                currentIntake: widget.carbIntake,
              ),
              TargetIntakeRow(
                nutrition: Nutrition.protein,
                currentIntake: widget.proteinIntake,
              ),
              TargetIntakeRow(
                nutrition: Nutrition.fat,
                currentIntake: widget.fatIntake,
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<RadialBarSeries<ChartData, String>> _getRadialBarCustomizedSeries() {
    return <RadialBarSeries<ChartData, String>>[
      RadialBarSeries<ChartData, String>(
        animationDuration: 750,
        maximumValue: 100,
        gap: '5%',
        radius: '100%',
        dataSource: <ChartData>[
          ChartData(
            x: 'Fat',
            y: fatPercent,
            pointColor: const Color(0xFF7FE3F0),
          ),
          ChartData(
            x: 'Protein',
            y: proteinPercent,
            pointColor: const Color(0xFFAF8EFF),
          ),
          ChartData(
            x: 'Carbohydrate',
            y: carbPercent,
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
