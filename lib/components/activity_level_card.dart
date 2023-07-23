import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import '../model/activity_level.dart';
import '../screens/onboarding/set_goal_screens/select_age_screen.dart';
import '../user_information_helper.dart';

class ActivityLevelCard extends StatelessWidget {
  ActivityLevelCard({super.key, required this.activityLevel});

  final UIHelper uiHelper = UIHelper();
  final ActivityLevel activityLevel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xFFE4DFFF),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
                child: Wrap(
                  spacing: 2.0,
                  children: [
                    for (int i = 0; i < activityLevel.level; i++)
                      Image.asset(
                        'assets/icons/fireOn.png',
                        width: 16.0,
                        height: 16.0,
                      ),
                    for (int i = 0; i < (5 - activityLevel.level); i++)
                      Image.asset(
                        'assets/icons/fireOff.png',
                        width: 16.0,
                        height: 16.0,
                      ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(37.0, 75.0, 37.0, 28.0),
            child: Column(
              children: [
                Image.asset(
                  activityLevel.image,
                  height: 120.0,
                  fit: BoxFit.fitHeight,
                ),
                const Spacer(),
                Text(activityLevel.title, style: carouselCardTitle),
                const SizedBox(height: 14.0),
                Wrap(
                  children: [
                    Text(
                      activityLevel.description,
                      style: carouselCardContents,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const Spacer(flex: 2),
                CupertinoButton(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(16.0),
                  onPressed: () {
                    Navigator.pushNamed(context, SelectAgeScreen.routeName);
                    uiHelper.updateUserInformation(level: activityLevel.level);
                  },
                  child: Text(
                    '선택하기',
                    style: buttonText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
