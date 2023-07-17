import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/nutrition_text_field.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/model/nutrition.dart';

import '../model/goal_calories.dart';
import '../user_information_helper.dart';

class EditGoalSheetScreen extends StatefulWidget {
  const EditGoalSheetScreen({super.key, required this.onChanged});

  final Function() onChanged;

  @override
  State<EditGoalSheetScreen> createState() => _EditGoalSheetScreenState();
}

class _EditGoalSheetScreenState extends State<EditGoalSheetScreen> {
  final TextEditingController carbController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: backgroundGradient,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CupertinoButton(
                    onPressed: null,
                    disabledColor: Colors.transparent,
                    child: Text(
                      '완료',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 18,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Text(
                    '목표 수정',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2D3142),
                      fontSize: 18,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: () async {
                      if (carbController.text.isNotEmpty &&
                          proteinController.text.isNotEmpty &&
                          fatController.text.isNotEmpty) {
                        final UIHelper uiHelper = UIHelper();
                        GoalCalories goal = uiHelper.getCalories();
                        final carb = double.parse(carbController.text).round();
                        final protein =
                            double.parse(proteinController.text).round();
                        final fat = double.parse(fatController.text).round();
                        goal.goalCarbohydrate = carb;
                        goal.goalProtein = protein;
                        goal.goalFat = fat;
                        goal.goalCalories = carb * 4 + protein * 4 + fat * 9;
                        await uiHelper.updateUserCalories(
                            basalMetabolicRate: goal.basalMetabolicRate!,
                            maintenanceCalories: goal.maintenanceCalories!,
                            goalCalories: goal.goalCalories!,
                            goalFat: goal.goalFat!,
                            goalProtein: goal.goalProtein!,
                            goalCarbohydrate: goal.goalCarbohydrate!);
                        widget.onChanged();
                      }
                      if (mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      '완료',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 8.0),
              NutritionTextField(
                  nutrition: Nutrition.carbohydrate,
                  controller: carbController,
                  onChanged: (_) {}),
              NutritionTextField(
                  nutrition: Nutrition.protein,
                  controller: proteinController,
                  onChanged: (_) {}),
              NutritionTextField(
                  nutrition: Nutrition.fat,
                  controller: fatController,
                  onChanged: (_) {}),
            ],
          ),
        ),
      ),
    );
  }
}
