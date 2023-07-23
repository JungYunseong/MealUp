import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/unit_button.dart';
import 'package:meal_up/model/unit.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_goal_weight_screen.dart';
import '../../../components/number_picker.dart';
import '../../../components/progress_bar.dart';
import '../../../constant.dart';
import '../../../user_information_helper.dart';

class SelectHeightScreen extends StatefulWidget {
  const SelectHeightScreen({super.key});

  static String routeName = '/select_height_screen';

  @override
  State<SelectHeightScreen> createState() => _SelectHeightScreenState();
}

class _SelectHeightScreenState extends State<SelectHeightScreen> {
  final UIHelper uiHelper = UIHelper();
  Unit selectedUnit = Unit.cm;
  int selectedHeight = 170;
  int feet = 1;
  int inches = 1;

  void convertCmToFeetAndInches(int cm) {
    const double cmPerInch = 2.54;
    const double inchPerFoot = 12.0;

    double totalInches = cm / cmPerInch;
    int setFeet = totalInches ~/ inchPerFoot;
    double setInches = totalInches.remainder(inchPerFoot);

    feet = setFeet;
    inches = setInches.round();
  }

  void convertFeetAndInchesToCm(int feet, int inches) {
    const double cmPerInch = 2.54;
    const double inchPerFoot = 12.0;

    double cm = (feet * inchPerFoot + inches) * cmPerInch;

    if (cm < 50) {
      cm = 50;
    } else if (cm > 300) {
      cm = 300;
    }

    selectedHeight = cm.round();
  }

  @override
  void initState() {
    if (uiHelper.getInformation().height != null) {
      selectedHeight = uiHelper.getInformation().height!;
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
          middle: ProgressBar(current: 4 / 6),
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
                  Text('STEP 4/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '키가 어떻게 되시나요?',
                    style: aiTitleText,
                  ),
                  const SizedBox(height: 45.0),
                  Row(
                    children: [
                      UnitButton(
                        unit: Unit.cm,
                        selectedUnit: selectedUnit,
                        onTap: () {
                          setState(() {
                            selectedUnit = Unit.cm;
                            convertFeetAndInchesToCm(feet, inches);
                          });
                        },
                      ),
                      const SizedBox(width: 10.0),
                      UnitButton(
                        unit: Unit.ft,
                        selectedUnit: selectedUnit,
                        onTap: () {
                          setState(() {
                            selectedUnit = Unit.ft;
                            convertCmToFeetAndInches(selectedHeight);
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(height: 42.0),
                  if (selectedUnit == Unit.cm)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: selectedHeight.toString(),
                            style: const TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D3142),
                              fontFamily: 'Rubik',
                            ),
                          ),
                          const TextSpan(
                            text: ' cm',
                            style: TextStyle(
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
                  if (selectedUnit == Unit.ft)
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: feet.toString(),
                            style: const TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D3142),
                              fontFamily: 'Rubik',
                            ),
                          ),
                          const TextSpan(
                            text: ' ft  ',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2D3142),
                              fontFamily: 'Rubik',
                            ),
                          ),
                          TextSpan(
                            text: inches.toString(),
                            style: const TextStyle(
                              fontSize: 50.0,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF2D3142),
                              fontFamily: 'Rubik',
                            ),
                          ),
                          const TextSpan(
                            text: ' in',
                            style: TextStyle(
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
                    value: selectedHeight,
                    itemCount: 39,
                    itemWidth: 8.0,
                    minValue: 50,
                    maxValue: 300,
                    haptics: true,
                    onChanged: (value) {
                      setState(() {
                        selectedHeight = value;
                        convertCmToFeetAndInches(value);
                      });
                    },
                  ),
                  const Spacer(),
                  CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SelectGoalWeightScreen.routeName);
                      uiHelper.updateUserInformation(height: selectedHeight);
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
