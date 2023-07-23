import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/model/unit.dart';
import '../../../components/number_picker.dart';
import '../../../components/progress_bar.dart';
import '../../../components/unit_button.dart';
import '../../../constant.dart';
import '../../../user_information_helper.dart';
import 'end_set_user_information_screen.dart';

class SelectWeightScreen extends StatefulWidget {
  const SelectWeightScreen({super.key});

  static String routeName = '/select_weight_screen';

  @override
  State<SelectWeightScreen> createState() => _SelectWeightScreenState();
}

class _SelectWeightScreenState extends State<SelectWeightScreen> {
  final UIHelper uiHelper = UIHelper();
  Unit selectedUnit = Unit.kg;
  int selectedWeight = 50;
  int lbs = 50;

  void convertKgToLbs(int kg) {
    const double lbsPerKg = 2.20462;

    double setLbs = kg * lbsPerKg;

    lbs = setLbs.round();
  }

  void convertLbsToKg(int lbs) {
    const double kgPerLbs = 0.45359237;

    double kg = lbs * kgPerLbs;

    selectedWeight = kg.round();
  }

  void calculateGoalCalories() {
    final userInformation = uiHelper.getInformation();
    final gender = userInformation.gender;
    final activityLevel = userInformation.activityLevel;
    final age = userInformation.age;
    final height = userInformation.height;
    final goalWeight = userInformation.goalWeight;
    final weight = userInformation.weight;

    double basalMetabolicRate;
    double maintenanceCalories;
    int goalCalories;
    int goalFat;
    int goalProtein;
    int goalCarbohydrate;

    switch (gender) {
      case 'Male':
        basalMetabolicRate =
            66 + (13.7 * weight!) + (5 * height!) - (6.8 * age!);
      case 'Female':
        basalMetabolicRate =
            655 + (9.6 * weight!) + (1.7 * height!) - (4.7 * age!);
      default:
        basalMetabolicRate =
            66 + (13.7 * weight!) + (5 * height!) - (6.8 * age!);
    }

    switch (activityLevel) {
      case 1:
        maintenanceCalories = basalMetabolicRate * 1.2;
      case 2:
        maintenanceCalories = basalMetabolicRate * 1.375;
      case 3:
        maintenanceCalories = basalMetabolicRate * 1.55;
      case 4:
        maintenanceCalories = basalMetabolicRate * 1.725;
      case 5:
        maintenanceCalories = basalMetabolicRate * 1.9;
      default:
        maintenanceCalories = basalMetabolicRate * 1.55;
    }

    if (weight > goalWeight!) {
      goalCalories = (maintenanceCalories * 0.8).round();
    } else if (weight < goalWeight) {
      goalCalories = (maintenanceCalories * 1.2).round();
    } else {
      goalCalories = maintenanceCalories.round();
    }

    goalFat = ((goalCalories * 0.2) / 9).round();
    goalProtein = ((goalCalories * 0.3) / 4).round();
    goalCarbohydrate = ((goalCalories * 0.5) / 4).round();

    uiHelper.updateUserCalories(
      basalMetabolicRate: basalMetabolicRate,
      maintenanceCalories: maintenanceCalories,
      goalCalories: goalCalories,
      goalFat: goalFat,
      goalProtein: goalProtein,
      goalCarbohydrate: goalCarbohydrate,
    );
  }

  @override
  void initState() {
    if (uiHelper.getInformation().weight != null) {
      selectedWeight = uiHelper.getInformation().weight!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: backgroundGradient,
      child: Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: ProgressBar(current: 6 / 6),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          transitionBetweenRoutes: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Row(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  Text('STEP 6/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '현재 체중을 알려주세요.',
                    style: aiTitleText,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 45.0),
                  Row(
                    children: [
                      UnitButton(
                        unit: Unit.kg,
                        selectedUnit: selectedUnit,
                        onTap: () {
                          setState(() {
                            selectedUnit = Unit.kg;
                            convertLbsToKg(lbs);
                          });
                        },
                      ),
                      const SizedBox(width: 10.0),
                      UnitButton(
                        unit: Unit.lbs,
                        selectedUnit: selectedUnit,
                        onTap: () {
                          setState(() {
                            selectedUnit = Unit.lbs;
                            convertKgToLbs(selectedWeight);
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 42.0),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: (selectedUnit == Unit.kg)
                              ? selectedWeight.toString()
                              : lbs.toString(),
                          style: const TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF2D3142),
                            fontFamily: 'Rubik',
                          ),
                        ),
                        TextSpan(
                          text: '  ${selectedUnit.convertToString}',
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF2D3142),
                            fontFamily: 'Rubik',
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 14.0),
                  NumberPicker(
                      value: selectedWeight,
                      itemCount: 39,
                      itemWidth: 8.0,
                      minValue: 10,
                      maxValue: 300,
                      haptics: true,
                      onChanged: (value) {
                        setState(() {
                          selectedWeight = value;
                          convertKgToLbs(value);
                        });
                      }),
                  const Spacer(),
                  CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () async {
                      Navigator.pushNamed(
                          context, EndSetUserInformationScreen.routeName);
                      await uiHelper.updateUserInformation(
                          weight: selectedWeight);
                      calculateGoalCalories();
                    },
                    child: Text(
                      '다음으로',
                      style: buttonText,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
