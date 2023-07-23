class FoodData {
  FoodData({
    required this.name,
    required this.makerName,
    required this.carb,
    required this.protein,
    required this.fat,
  });

  late final String name;
  late final String makerName;
  late final String carb;
  late final String protein;
  late final String fat;

  FoodData.fromJson(Map<String, dynamic> json) {
    name = json['DESC_KOR'];
    makerName = json['MAKER_NAME'];
    carb = json['NUTR_CONT2'];
    protein = json['NUTR_CONT3'];
    fat = json['NUTR_CONT4'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['DESC_KOR'] = name;
    data['MAKER_NAME'] = makerName;
    data['NUTR_CONT2'] = carb;
    data['NUTR_CONT3'] = protein;
    data['NUTR_CONT4'] = fat;
    return data;
  }
}
