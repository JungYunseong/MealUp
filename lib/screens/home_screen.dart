import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../components/date_picker/date_picker_widget.dart';
import '../components/intaked_food_box.dart';
import '../components/target_intake_card.dart';
import '../constant.dart';
import '../database_helper.dart';
import '../model/food_item.dart';
import '../model/intakes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.installDate});

  final DateTime installDate;

  static String routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();

  List<FoodItem> breakfast = [];
  List<FoodItem> lunch = [];
  List<FoodItem> dinner = [];

  int carbIntake = 0;
  int proteinIntake = 0;
  int fatIntake = 0;

  Intakes? retrievedIntake;

  Future<Intakes?> getIntake(int intakeId) async {
    final dbHelper = DatabaseHelper.instance;
    retrievedIntake = await dbHelper.getIntake(intakeId);
    return retrievedIntake;
  }

  (int, int, int) calculateIntake() {
    int carb = 0;
    int protein = 0;
    int fat = 0;
    for (FoodItem item in breakfast) {
      carb = carb + item.carb;
      protein = protein + item.protein;
      fat = fat + item.fat;
    }
    for (FoodItem item in lunch) {
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

  Future<void> fetchIntakes(DateTime date) async {
    final dateFormat = DateFormat('yyyyMMdd');
    final formattedDate = dateFormat.format(date);
    final id = int.parse(formattedDate);
    final retrieveIntake = await getIntake(id);

    setState(() {
      retrievedIntake = retrieveIntake;
      breakfast = retrieveIntake?.breakfast ?? [];
      lunch = retrieveIntake?.lunch ?? [];
      dinner = retrieveIntake?.dinner ?? [];
    });

    fetchNutrition();
  }

  void fetchNutrition() {
    final (carb, protein, fat) = calculateIntake();
    setState(() {
      carbIntake = carb;
      proteinIntake = protein;
      fatIntake = fat;
    });
  }

  @override
  void initState() {
    fetchNutrition();
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
            fetchIntakes(date);
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
                top: Radius.circular(24),
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
                  selectedDate: _selectedDate,
                  mealTime: '아침',
                  foodList: breakfast,
                  retrieveIntake: retrievedIntake,
                ),
                const SizedBox(height: 16.0),
                IntakedFoodBox(
                  selectedDate: _selectedDate,
                  mealTime: '점심',
                  foodList: lunch,
                  retrieveIntake: retrievedIntake,
                ),
                const SizedBox(height: 16.0),
                IntakedFoodBox(
                  selectedDate: _selectedDate,
                  mealTime: '저녁',
                  foodList: dinner,
                  retrieveIntake: retrievedIntake,
                ),
                const SizedBox(height: 100.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
