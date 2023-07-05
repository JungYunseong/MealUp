class FoodItem {
  late final String? thumbnail;
  late final String name;
  late final int carb;
  late final int protein;
  late final int fat;

  FoodItem({
    this.thumbnail,
    required this.name,
    required this.carb,
    required this.protein,
    required this.fat,
  });

  FoodItem.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    name = json['name'];
    carb = json['carb'];
    protein = json['protein'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['thumbnail'] = thumbnail;
    data['name'] = name;
    data['carb'] = carb;
    data['protein'] = protein;
    data['fat'] = fat;

    return data;
  }
}
