import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/model/unit.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_weight_screen.dart';
import '../../../components/number_picker.dart';
import '../../../components/progress_bar.dart';
import '../../../components/unit_button.dart';
import '../../../constant.dart';
import '../../../user_information_helper.dart';

class SelectGoalWeightScreen extends StatefulWidget {
  const SelectGoalWeightScreen({super.key});

  static String routeName = '/select_weight_goal_screen';

  @override
  State<SelectGoalWeightScreen> createState() => _SelectGoalWeightScreenState();
}

class _SelectGoalWeightScreenState extends State<SelectGoalWeightScreen> {
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

  @override
  void initState() {
    if (uiHelper.getInformation().goalWeight != null) {
      selectedWeight = uiHelper.getInformation().goalWeight!;
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
          middle: ProgressBar(current: 5 / 6),
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
                  Text('STEP 5/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '목표 체중을 알려주세요.',
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
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SelectWeightScreen.routeName);
                      uiHelper.updateUserInformation(
                        goalWeight: selectedWeight,
                      );
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
