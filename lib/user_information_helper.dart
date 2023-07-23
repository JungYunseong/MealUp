import 'dart:convert';

import 'package:meal_up/model/weight.dart';
import 'package:meal_up/utils/date_coverter.dart';
import 'package:meal_up/weight_database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/goal_calories.dart';
import 'model/gender.dart';
import 'model/user_information.dart';

class UIHelper {
  static late SharedPreferences prefs;
  final dbHelper = WeightDatabaseHelper();

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future updateUserInformation({
    Gender? gender,
    int? level,
    int? age,
    int? height,
    int? goalWeight,
    int? weight,
  }) async {
    UserInformation userInformation = UserInformation();
    userInformation = UserInformation.fromJson(
      jsonDecode(prefs.getString('UserInformation') ?? '{}'),
    );

    int? getAge = userInformation.age;
    String? getGender = userInformation.gender;
    int? getLevel = userInformation.activityLevel;
    int? getHeight = userInformation.height;
    int? getGoalWeight = userInformation.goalWeight;
    int? getWeight = userInformation.weight;

    if (age != null) {
      getAge = age;
    }

    if (gender != null) {
      getGender = gender.convertToString;
    }

    if (level != null) {
      getLevel = level;
    }

    if (height != null) {
      getHeight = height;
    }

    if (goalWeight != null) {
      getGoalWeight = goalWeight;
    }

    if (weight != null) {
      getWeight = weight;
    }

    final information = UserInformation(
      gender: getGender,
      activityLevel: getLevel,
      age: getAge,
      height: getHeight,
      goalWeight: getGoalWeight,
      weight: getWeight,
    );

    if (getWeight != null) {
      dbHelper.insertWeightEntry(WeightEntry(
        id: dateTimeToInt(DateTime.now()),
        date: dateTimeToInt(DateTime.now()),
        weight: getWeight.toDouble(),
      ));
    }
    prefs.setString('UserInformation', json.encode(information.toJson()));
    final installDate = prefs.getInt('InstallDate');
    if (installDate == null) {
      prefs.setInt('InstallDate', dateTimeToInt(DateTime.now()));
    }
  }

  UserInformation getInformation() {
    UserInformation userInformation = UserInformation.fromJson(
      jsonDecode(prefs.getString('UserInformation') ?? '{}'),
    );

    return userInformation;
  }

  Future updateUserCalories({
    required double basalMetabolicRate,
    required double maintenanceCalories,
    required int goalCalories,
    required int goalFat,
    required int goalProtein,
    required int goalCarbohydrate,
  }) async {
    final calories = GoalCalories(
      basalMetabolicRate: basalMetabolicRate,
      maintenanceCalories: maintenanceCalories,
      goalCalories: goalCalories,
      goalFat: goalFat,
      goalProtein: goalProtein,
      goalCarbohydrate: goalCarbohydrate,
    );

    prefs.remove('GoalCalories');
    prefs.setString('GoalCalories', json.encode(calories.toJson()));
  }

  GoalCalories getCalories() {
    GoalCalories goalCalories = GoalCalories.fromJson(
      jsonDecode(prefs.getString('GoalCalories') ?? '{}'),
    );

    return goalCalories;
  }
}
