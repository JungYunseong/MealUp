class GoalCalories {
  double? basalMetabolicRate;
  double? maintenanceCalories;
  int? goalCalories;
  int? goalFat;
  int? goalProtein;
  int? goalCarbohydrate;

  GoalCalories({
    this.basalMetabolicRate,
    this.maintenanceCalories,
    this.goalCalories,
    this.goalFat,
    this.goalProtein,
    this.goalCarbohydrate,
  });

  GoalCalories.fromJson(Map<String, dynamic> informationMap) {
    basalMetabolicRate = informationMap['basalMetabolicRate'];
    maintenanceCalories = informationMap['maintenanceCalories'];
    goalCalories = informationMap['goalCalories'];
    goalFat = informationMap['goalFat'];
    goalProtein = informationMap['goalProtein'];
    goalCarbohydrate = informationMap['goalCarbohydrate'];
  }

  Map<String, dynamic> toJson() {
    return {
      'basalMetabolicRate': basalMetabolicRate,
      'maintenanceCalories': maintenanceCalories,
      'goalCalories': goalCalories,
      'goalFat': goalFat,
      'goalProtein': goalProtein,
      'goalCarbohydrate': goalCarbohydrate,
    };
  }
}
