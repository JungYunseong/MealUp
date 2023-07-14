import 'food_item.dart';

class Intakes {
  int id;
  String date;
  List<FoodItem> breakfast;
  List<FoodItem> lunch;
  List<FoodItem> dinner;

  Intakes({
    required this.id,
    required this.date,
    this.breakfast = const [],
    this.lunch = const [],
    this.dinner = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'breakfast': breakfast.map((food) => food.toMap()).toList(),
      'lunch': lunch.map((food) => food.toMap()).toList(),
      'dinner': dinner.map((food) => food.toMap()).toList(),
    };
  }

  static Intakes fromMap(Map<String, dynamic> map) {
    return Intakes(
      id: map['id'],
      date: map['date'],
      breakfast: List<FoodItem>.from(
        map['breakfast'].map((food) => FoodItem.fromMap(food)),
      ),
      lunch: List<FoodItem>.from(
        map['lunch'].map((food) => FoodItem.fromMap(food)),
      ),
      dinner: List<FoodItem>.from(
        map['dinner'].map((food) => FoodItem.fromMap(food)),
      ),
    );
  }
}
