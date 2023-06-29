import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/routes.dart';
import 'package:meal_up/screens/tab_screen.dart';
import 'package:meal_up/screens/onboarding/onboarding_screen.dart';
import 'package:meal_up/user_information_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Up',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _isCaloriesSet(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data!) {
              return const TabScreen();
            } else {
              return const OnboardingScreen();
            }
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      routes: routes,
    );
  }

  Future<bool> _isCaloriesSet() async {
    UIHelper uiHelper = UIHelper();
    await uiHelper.init();
    bool isSet = (uiHelper.getCalories().goalCalories != null);
    return isSet;
  }
}
