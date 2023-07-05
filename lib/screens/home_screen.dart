import 'package:flutter/material.dart';
import '../components/date_picker/date_picker_widget.dart';
import '../components/intaked_food_box.dart';
import '../components/target_intake_card.dart';
import '../constant.dart';
import '../model/food_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.installDate});

  final DateTime installDate;

  static String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  final List<FoodItem> breakfast = [
    FoodItem(
        name: 'Salad with wheat and white egg', carb: 15, protein: 20, fat: 4),
    FoodItem(name: 'Pumpkin soup', carb: 12, protein: 32, fat: 8),
  ];
  final List<FoodItem> launch = [];
  final List<FoodItem> dinner = [];

  int carbIntake = 0;
  int proteinIntake = 0;
  int fatIntake = 0;

  (int, int, int) calculateIntake() {
    int carb = 0;
    int protein = 0;
    int fat = 0;
    for (FoodItem item in breakfast) {
      carb = carb + item.carb;
      protein = protein + item.protein;
      fat = fat + item.fat;
    }
    for (FoodItem item in launch) {
      carb = carb + item.carb;
      protein = protein + item.protein;
      fat = fat + item.fat;
    }
    for (FoodItem item in dinner) {
      carb = carb + item.carb;
      protein = protein + item.protein;
      fat = fat + item.fat;
    }

    return (carb, protein, fat);
  }

  @override
  void initState() {
    final (carb, protein, fat) = calculateIntake();
    setState(() {
      carbIntake = carb;
      proteinIntake = protein;
      fatIntake = fat;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '식단관리',
          style: navTitle,
        ),
        const SizedBox(height: 16.0),
        DatePicker(
          widget.installDate,
          initialSelectedDate: DateTime.now(),
          onDateChange: (date) {
            setState(() {
              _selectedDate = date;
            });
          },
        ),
        const SizedBox(height: 24.0),
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
              color: Color(0xFFF4F6FA),
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 27.0),
                TargetIntake(
                  selectedDate: _selectedDate,
                  carbIntake: carbIntake,
                  proteinIntake: proteinIntake,
                  fatIntake: fatIntake,
                ),
                const SizedBox(height: 16.0),
                IntakedFoodBox(
                  mealTime: '아침',
                  foodList: breakfast,
                ),
                const SizedBox(height: 16.0),
                IntakedFoodBox(
                  mealTime: '점심',
                  foodList: launch,
                ),
                const SizedBox(height: 16.0),
                IntakedFoodBox(
                  mealTime: '저녁',
                  foodList: dinner,
                ),
                const SizedBox(height: 550),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
