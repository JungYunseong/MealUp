class UserInformation {
  String? gender;
  int? activityLevel;
  int? age;
  int? height;
  int? goalWeight;
  int? weight;

  UserInformation({
    this.gender,
    this.age,
    this.activityLevel,
    this.height,
    this.goalWeight,
    this.weight,
  });

  UserInformation.fromJson(Map<String, dynamic> informationMap) {
    gender = informationMap['gender'];
    activityLevel = informationMap['activityLevel'];
    age = informationMap['age'];
    height = informationMap['height'];
    goalWeight = informationMap['goalWeight'];
    weight = informationMap['weight'];
  }

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'activityLevel': activityLevel,
      'age': age,
      'height': height,
      'goalWeight': goalWeight,
      'weight': weight,
    };
  }
}
