import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_height_screen.dart';

import '../../../components/progress_bar.dart';
import '../../../constant.dart';
import '../../../user_information_helper.dart';

class SelectAgeScreen extends StatefulWidget {
  const SelectAgeScreen({super.key});

  static String routeName = '/select_age_screen';

  @override
  State<SelectAgeScreen> createState() => _SelectAgeScreenState();
}

class _SelectAgeScreenState extends State<SelectAgeScreen> {
  final UIHelper uiHelper = UIHelper();
  final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 24);
  final List<int> ages = [for (var i = 1; i <= 100; i++) i];
  int selectedAge = 25;

  @override
  void initState() {
    if (uiHelper.getInformation().age != null) {
      selectedAge = uiHelper.getInformation().age!;
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
          middle: ProgressBar(current: 3 / 6),
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
                  Text('STEP 3/6', style: aiStepText),
                  const SizedBox(height: 10.0),
                  Text(
                    '나이가 어떻게 되시나요?',
                    style: aiTitleText,
                  ),
                  const SizedBox(height: 45.0),
                  SizedBox(
                    width: 300.0,
                    height: 200.0,
                    child: CupertinoPicker.builder(
                        scrollController: controller,
                        itemExtent: 50,
                        childCount: ages.length,
                        onSelectedItemChanged: (index) {
                          setState(() {
                            selectedAge = ages[index];
                          });
                        },
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: 50.0,
                            child: Center(
                              child: Text(
                                ages[index].toString(),
                              ),
                            ),
                          );
                        }),
                  ),
                  const Spacer(),
                  CupertinoButton(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.0),
                    onPressed: () {
                      Navigator.pushNamed(
                          context, SelectHeightScreen.routeName);
                      uiHelper.updateUserInformation(
                        age: selectedAge,
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
