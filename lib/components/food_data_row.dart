import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/model/food_data.dart';

class FoodDataList extends StatelessWidget {
  const FoodDataList({super.key, required this.data, required this.onSelect});

  final List<FoodData> data;
  final Function(String name, String carb, String protein, String fat) onSelect;

  Widget row(FoodData food) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: const TextStyle(
                    color: primaryTextColor,
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.20,
                    overflow: TextOverflow.ellipsis
                  ),
                  maxLines: 1,
                ),
                Text(
                  food.makerName,
                  style: const TextStyle(
                    color: Color(0xFF9C9DB9),
                    fontSize: 14,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.20,
                  ),
                ),
              ],
            ),
          ),
          CupertinoButton(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              color: primaryColor,
              child: const Text(
                '선택',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Noto Sans KR',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.20,
                ),
              ),
              onPressed: () {
                onSelect(
                  food.name,
                  food.carb,
                  food.protein,
                  food.fat,
                );
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              '검색 결과',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontFamily: 'Noto Sans KR',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 8.0),
                for (FoodData food in data) row(food),
                const Row(
                  children: [
                    Spacer(),
                    Text(
                      '* 검색 결과 상위 20개만 노출됩니다.',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w400,
                        height: 2,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
