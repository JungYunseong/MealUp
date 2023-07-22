import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/gender.dart';
import '../model/goal_calories.dart';
import '../model/user_information.dart';

class Setting extends ChangeNotifier {
  Gender? _gender;
  int? _level;
  int? _age;
  int? _height;
  int? _goalWeight;
  int? _weight;
  double? _basalMetabolicRate;
  double? _maintenanceCalories;
  int? _goalCalories;
  int? _goalFat;
  int? _goalProtein;
  int? _goalCarbohydrate;

  Gender? get gender => _gender;
  int? get level => _level;
  int? get age => _age;
  int? get height => _height;
  int? get goalWeight => _goalWeight;
  int? get weight => _weight;
  double? get basalMetabolicRate => _basalMetabolicRate;
  double? get maintenanceCalories => _maintenanceCalories;
  int? get goalCalories => _goalCalories;
  int? get goalFat => _goalFat;
  int? get goalProtein => _goalProtein;
  int? get goalCarbohydrate => _goalCarbohydrate;

  Future<void> getSettingValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserInformation userInfo = getInformation(prefs);
    switch (userInfo.gender) {
      case 'Male':
        _gender = Gender.male;
      case 'Female':
        _gender = Gender.female;
    }
    _level = userInfo.activityLevel;
    _age = userInfo.age;
    _height = userInfo.height;
    _goalWeight = userInfo.goalWeight;
    _weight = userInfo.weight;

    GoalCalories goalCalories = getCalories(prefs);
    _basalMetabolicRate = goalCalories.basalMetabolicRate;
    _maintenanceCalories = goalCalories.maintenanceCalories;
    _goalCalories = goalCalories.goalCalories;
    _goalFat = goalCalories.goalFat;
    _goalProtein = goalCalories.goalProtein;
    _goalCarbohydrate = goalCalories.goalCarbohydrate;

    notifyListeners();
  }

  UserInformation getInformation(SharedPreferences prefs) {
    UserInformation userInformation = UserInformation.fromJson(
      jsonDecode(prefs.getString('UserInformation') ?? '{}'),
    );

    return userInformation;
  }

  GoalCalories getCalories(SharedPreferences prefs) {
    GoalCalories goalCalories = GoalCalories.fromJson(
      jsonDecode(prefs.getString('GoalCalories') ?? '{}'),
    );

    return goalCalories;
  }
}
