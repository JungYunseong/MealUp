import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meal_up/components/food_row.dart';
import 'package:meal_up/intake_database_helper.dart';
import 'package:meal_up/model/food_item.dart';
import 'package:meal_up/screens/add_food_screen.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../model/intakes.dart';

class IntakedFoodBox extends StatefulWidget {
  const IntakedFoodBox({
    super.key,
    required this.selectedDate,
    required this.mealTime,
    required this.foodList,
    required this.retrieveIntake,
    required this.onDismiss,
  });

  final DateTime selectedDate;
  final String mealTime;
  final List<FoodItem> foodList;
  final Intakes? retrieveIntake;
  final Function() onDismiss;

  @override
  State<IntakedFoodBox> createState() => _IntakedFoodBoxState();
}

class _IntakedFoodBoxState extends State<IntakedFoodBox> {
  int kcalSum = 0;

  void calculateKcal() {
    int kcal = 0;
    for (FoodItem item in widget.foodList) {
      kcal = kcal + (item.carb * 4);
      kcal = kcal + (item.protein * 4);
      kcal = kcal + (item.fat * 9);
    }
    kcalSum = kcal;
  }

  Future deleteFood(FoodItem foodItem) async {
    final dbHelper = IntakeDatabaseHelper.instance;
    var updateIntake = widget.retrieveIntake;

    switch (widget.mealTime) {
      case '아침':
        updateIntake!.breakfast.remove(foodItem);
      case '점심':
        updateIntake!.lunch.remove(foodItem);
      case '저녁':
        updateIntake!.dinner.remove(foodItem);
    }

    await dbHelper.updateIntake(updateIntake!);
  }

  @override
  Widget build(BuildContext context) {
    calculateKcal();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: ClipRect(
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x266F88D1),
                blurRadius: 30,
                offset: Offset(0, 10),
                spreadRadius: 0,
              )
            ],
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 20.0, 28.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.mealTime,
                          style: const TextStyle(
                            color: Color(0xFF7265E3),
                            fontSize: 12,
                            fontFamily: 'Noto Sans KR',
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 14.0),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icons/fireOn.png',
                              width: 16.0,
                              fit: BoxFit.fitWidth,
                            ),
                            const SizedBox(width: 11.0),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$kcalSum ',
                                    style: const TextStyle(
                                      color: Color(0xFF2D3142),
                                      fontSize: 24,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.27,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: 'kcal',
                                    style: TextStyle(
                                      color: Color(0xFF2D3142),
                                      fontSize: 12,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 0.13,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4DFFF),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            CupertinoIcons.plus,
                            color: Color(0xFF7265E3),
                            size: 24.0,
                          ),
                        ),
                      ),
                      onPressed: () async {
                        final idFormat = DateFormat('yyyyMMdd');
                        final dateFormat = DateFormat('yyyy-MM-dd');
                        final formattedId =
                            idFormat.format(widget.selectedDate);
                        final date = dateFormat.format(widget.selectedDate);
                        final id = int.parse(formattedId);

                        if (mounted) {
                          Navigator.pushNamed(
                            context,
                            AddFoodScreen.routeName,
                            arguments: AddFoodScreenArguments(
                              id: id,
                              date: date,
                              mealTime: widget.mealTime,
                              retrieveIntake: widget.retrieveIntake,
                              onDismiss: widget.onDismiss,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0),
              if (widget.foodList.isNotEmpty)
                Column(
                  children: widget.foodList.map((item) {
                    final int kcal =
                        (item.carb * 4) + (item.protein * 4) + (item.fat * 9);
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.25,
                        motion: const ScrollMotion(),
                        children: [
                          CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: Colors.red,
                              ),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            onPressed: () async{
                              await deleteFood(item);
                              widget.onDismiss();
                            },
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 28.0),
                        child: FoodRow(
                          thumbnail: item.thumbnail,
                          name: item.name,
                          kcal: kcal,
                        ),
                      ),
                    );
                  }).toList(),
                )
              else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    '${widget.mealTime}에 섭취한 식단을 등록해 주세요',
                    style: const TextStyle(
                      color: Color(0xFF9C9DB9),
                      fontSize: 14,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.20,
                    ),
                  ),
                ),
              const SizedBox(height: 28.0),
            ],
          ),
        ),
      ),
    );
  }
}
