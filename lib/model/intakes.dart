import 'package:flutter/cupertino.dart';
import 'food_item.dart';

class Intakes {
  Intakes({
    required this.id,
    required this.date,
    required this.breakfast,
    required this.launch,
    required this.dinner,
  });

  late final Key id;
  late final String date;
  late final List<FoodItem> breakfast;
  late final List<FoodItem> launch;
  late final List<FoodItem> dinner;
  
  Intakes.fromJson(Map<String, dynamic> json){
    date = json['date'];
    breakfast = List.from(json['breakfast']).map((e) => FoodItem.fromJson(e)).toList();
    launch = List.from(json['launch']).map((e) => FoodItem.fromJson(e)).toList();
    dinner = List.from(json['dinner']).map((e) => FoodItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date;
    data['breakfast'] = breakfast.map((e) => e.toJson()).toList();
    data['launch'] = launch.map((e) => e.toJson()).toList();
    data['dinner'] = dinner.map((e) => e.toJson()).toList();
    return data;
  }
}