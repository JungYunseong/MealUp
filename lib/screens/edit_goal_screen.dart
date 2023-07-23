import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/target_intake_row.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:meal_up/providers/setting_provider.dart';
import 'package:meal_up/screens/edit_goal_sheet_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_gender_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class EditGoalScreenArguments {
  final Function() onDismiss;
  EditGoalScreenArguments(this.onDismiss);
}

class EditGoalScreen extends StatefulWidget {
  const EditGoalScreen({super.key, required this.onDismiss});

  final Function() onDismiss;

  static String routeName = '/edit_goal_screen';

  @override
  State<EditGoalScreen> createState() => _EditGoalScreenState();
}

class _EditGoalScreenState extends State<EditGoalScreen> {
  void editGoal(BuildContext context) {
    showBarModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return EditGoalSheetScreen(
          onChanged: () {
            setState(() {
              context.read<Setting>().getSettingValue();
            });
          },
        );
      },
    );
  }

  @override
  void dispose() {
    widget.onDismiss();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
                decoration: ShapeDecoration(
                  color: const Color(0xFFE3DEFF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '추천 칼로리',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF7265E3),
                        fontSize: 14,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, SelectGenderScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 34.0),
                const Text(
                  '하루 섭취',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF7265E3),
                    fontSize: 12,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 7.0),
                Text.rich(
                  TextSpan(
                    children: [
                      const TextSpan(
                        text: '하루 ',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 28,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: '${context.read<Setting>().goalCalories} Kcal',
                        style: const TextStyle(
                          color: Color(0xFF7265E3),
                          fontSize: 28,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const TextSpan(
                        text: '를',
                        style: TextStyle(
                          color: Color(0xFF2D3142),
                          fontSize: 28,
                          fontFamily: 'Noto Sans KR',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  '섭취합니다.',
                  style: TextStyle(
                    color: Color(0xFF2D3142),
                    fontSize: 28,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 55),
                TargetIntakeRow(
                  nutrition: Nutrition.carbohydrate,
                  currentIntake: context.read<Setting>().goalCarbohydrate!,
                  isEditScreen: true,
                ),
                TargetIntakeRow(
                  nutrition: Nutrition.protein,
                  currentIntake: context.read<Setting>().goalProtein!,
                  isEditScreen: true,
                ),
                TargetIntakeRow(
                  nutrition: Nutrition.fat,
                  currentIntake: context.read<Setting>().goalFat!,
                  isEditScreen: true,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () {
                      editGoal(context);
                    },
                    child: Text(
                      '목표 수정하기',
                      style: buttonText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
