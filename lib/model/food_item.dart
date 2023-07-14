class FoodItem {
  int? id;
  String type;
  String? thumbnail;
  String name;
  int carb;
  int protein;
  int fat;

  FoodItem({
    this.id,
    required this.type,
    this.thumbnail,
    required this.name,
    required this.carb,
    required this.protein,
    required this.fat,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'thumbnail': thumbnail,
      'name': name,
      'carb': carb,
      'protein': protein,
      'fat': fat,
    };
  }

  static FoodItem fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'],
      type: map['type'],
      thumbnail: map['thumbnail'],
      name: map['name'],
      carb: map['carb'],
      protein: map['protein'],
      fat: map['fat'],
    );
  }
}
