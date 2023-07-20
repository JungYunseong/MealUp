import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/providers/setting_provider.dart';
import 'package:meal_up/routes.dart';
import 'package:meal_up/screens/add_food_screen.dart';
import 'package:meal_up/screens/edit_goal_screen.dart';
import 'package:meal_up/screens/tab_screen.dart';
import 'package:meal_up/screens/onboarding/onboarding_screen.dart';
import 'package:meal_up/user_information_helper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final providers = [
    ChangeNotifierProvider(create: (_) => Setting()),
  ];

  runApp(MultiProvider(
    providers: providers,
    child: const MyApp(),
  ));
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/add_food_screen':
            final arguments = settings.arguments as AddFoodScreenArguments;
            return MaterialPageRoute(
              builder: (context) => AddFoodScreen(
                id: arguments.id,
                date: arguments.date,
                mealTime: arguments.mealTime,
                retrieveIntake: arguments.retrieveIntake,
                onDismiss: arguments.onDismiss,
              ),
            );

          case '/edit_goal_screen':
            final arguments = settings.arguments as EditGoalScreenArguments;
            return MaterialPageRoute(
              builder: (context) =>
                  EditGoalScreen(onDismiss: arguments.onDismiss),
            );
        }
        return null;
      },
    );
  }

  Future<bool> _isCaloriesSet() async {
    UIHelper uiHelper = UIHelper();
    await uiHelper.init();
    bool isSet = (uiHelper.getCalories().goalCalories != null);
    return isSet;
  }
}
