import 'package:meal_up/screens/edit_goal_screen.dart';
import 'package:meal_up/screens/tab_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/end_set_user_information_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_activity_level_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_age_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_gender_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_goal_weight_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_height_screen.dart';
import 'package:meal_up/screens/onboarding/set_goal_screens/select_weight_screen.dart';

final routes = {
  SelectGenderScreen.routeName: (context) => const SelectGenderScreen(),
  SelectActivityLevelScreen.routeName: (context) => SelectActivityLevelScreen(),
  SelectAgeScreen.routeName: (context) => const SelectAgeScreen(),
  SelectHeightScreen.routeName: (context) => const SelectHeightScreen(),
  SelectGoalWeightScreen.routeName: (context) => const SelectGoalWeightScreen(),
  SelectWeightScreen.routeName: (context) => const SelectWeightScreen(),
  EndSetUserInformationScreen.routeName: (context) =>
      EndSetUserInformationScreen(),
  TabScreen.routeName: (context) => const TabScreen(),
  EditGoalScreen.routeName: (context) => const EditGoalScreen(),
};
