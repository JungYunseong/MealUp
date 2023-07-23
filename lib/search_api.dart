import 'dart:convert';

import 'package:meal_up/model/food_data.dart';
import 'package:http/http.dart' as http;

class SearchAPI {
  final key = 'eb374cba31dd47e599ff';

  Future<List<FoodData>> fetch(String query) async {
    final uri =
        'http://openapi.foodsafetykorea.go.kr/api/$key/I2790/json/1/100/DESC_KOR=$query';
    final response = await http.get(Uri.parse(uri));

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);
    Iterable? row = jsonResponse['I2790']['row'];
    final rawData = row?.map((e) => FoodData.fromJson(e)).toList();

    List<FoodData> fetchedData = [];
    for (FoodData data in rawData ?? []) {
      if (data.carb.isNotEmpty &&
          data.protein.isNotEmpty &&
          data.fat.isNotEmpty &&
          fetchedData.length < 20) {
        fetchedData.add(data);
      }
    }
    return fetchedData;
  }
}
