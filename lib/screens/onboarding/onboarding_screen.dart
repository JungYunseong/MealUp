import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_gender_screen.dart';
import 'package:meal_up/user_information_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final UIHelper uiHelper = UIHelper();

  @override
  void initState() {
    uiHelper.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: backgroundGradient,
          child: SafeArea(
            child: Column(
              children: [
                const Spacer(),
                Image.asset(
                  'assets/icons/logo.png',
                  width: 65.0,
                  height: 65.0,
                  fit: BoxFit.fitHeight,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                Text(
                  'Meal Up',
                  style: onboardingTitle,
                ),
                const Spacer(),
                Text(
                  'Meal Up과 함께',
                  style: onboardingContents,
                ),
                Text(
                  '성공적인 식단관리를 해보세요!',
                  style: onboardingContents,
                ),
                const Spacer(),
                CupertinoButton(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                  onPressed: () {
                    Navigator.pushNamed(context, SelectGenderScreen.routeName);
                  },
                  child: Text(
                    '지금 시작하기',
                    style: buttonText,
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
