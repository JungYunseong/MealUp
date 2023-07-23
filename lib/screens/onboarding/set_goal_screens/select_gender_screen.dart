import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/gender_button.dart';
import 'package:meal_up/components/progress_bar.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_activity_level_screen.dart';
import '../../../constant.dart';
import '../../../model/gender.dart';
import '../../../user_information_helper.dart';

class SelectGenderScreen extends StatefulWidget {
  const SelectGenderScreen({super.key});

  static String routeName = '/select_gender_screen';

  @override
  State<SelectGenderScreen> createState() => _SelectGenderScreenState();
}

class _SelectGenderScreenState extends State<SelectGenderScreen> {
  final UIHelper uiHelper = UIHelper();
  Gender selectedGender = Gender.male;

  @override
  void initState() {
    if (uiHelper.getInformation().gender != null) {
      switch (uiHelper.getInformation().gender) {
        case 'Male':
          selectedGender = Gender.male;
        case 'Female':
          selectedGender = Gender.female;
      }
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
          middle: ProgressBar(current: 1 / 6),
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
                  Text('STEP 1/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '성별이 무엇인가요?',
                    style: aiTitleText,
                  ),
                  const SizedBox(height: 45.0),
                  Row(
                    children: [
                      GenderButton(
                        gender: Gender.male,
                        selectedGender: selectedGender,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                      ),
                      const SizedBox(width: 10.0),
                      GenderButton(
                        gender: Gender.female,
                        selectedGender: selectedGender,
                        onTap: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 45.0),
                  Text('개인화된 정보를 제공해드리기 위해', style: aiContentText),
                  Text('성별 정보가 필요합니다.', style: aiContentText),
                  const Spacer(),
                  CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SelectActivityLevelScreen.routeName);
                      uiHelper.updateUserInformation(
                        gender: selectedGender,
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
