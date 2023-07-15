import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/screens/barcode_scanner_screen.dart';
import '../constant.dart';
import '../database_helper.dart';
import '../model/food_item.dart';
import '../model/intakes.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  static String routeName = '/add_food_screen';

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  String testText = '바코드 스캔';

  void scanBarcode(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: const BarcodeScannerScreen(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: backgroundGradient,
      child: Scaffold(
        appBar: const CupertinoNavigationBar(
          middle: Text(
            '음식 검색',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Noto Sans KR',
              fontWeight: FontWeight.w500,
            ),
          ),
          border: Border(bottom: BorderSide(color: Colors.transparent)),
          transitionBetweenRoutes: false,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16.0),
                    Container(
                      height: 60,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        shadows: const [
                          BoxShadow(
                            color: Color(0x144075CD),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Center(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(20.0),
                            suffixIcon: CupertinoButton(
                                child: const Icon(CupertinoIcons.search),
                                onPressed: () {}),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 27.0),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () async {
                              scanBarcode(context);
                            },
                            child: Text(
                              testText,
                              style: buttonText,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: CupertinoButton(
                            padding: const EdgeInsets.symmetric(vertical: 17.0),
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: () {},
                            child: Text(
                              '빠른 추가',
                              style: buttonText,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Create a new Intakes object
  final intakes = Intakes(
    id: 20230714,
    date: '2023-07-14',
    breakfast: [
      FoodItem(
          thumbnail: null,
          type: 'breakfast',
          name: 'Toast',
          carb: 20,
          protein: 5,
          fat: 10),
      FoodItem(
          thumbnail: null,
          type: 'breakfast',
          name: 'Eggs',
          carb: 5,
          protein: 10,
          fat: 15),
    ],
    lunch: [
      FoodItem(
          thumbnail: null,
          type: 'lunch',
          name: 'Chicken',
          carb: 10,
          protein: 25,
          fat: 15),
      FoodItem(
          thumbnail: null,
          type: 'lunch',
          name: 'Rice',
          carb: 30,
          protein: 5,
          fat: 2),
    ],
    dinner: [
      FoodItem(
          thumbnail: null,
          type: 'dinner',
          name: 'Salmon',
          carb: 5,
          protein: 20,
          fat: 10),
      FoodItem(
          thumbnail: null,
          type: 'dinner',
          name: 'Broccoli',
          carb: 5,
          protein: 2,
          fat: 1),
    ],
  );

  final dbHelper = DatabaseHelper.instance;
// Save the Intakes object to the database
  void saveIntake() async {
    await dbHelper.createIntake(intakes);
  }

// Retrieve all Intakes objects from the database
  Future<Intakes?> retrieveIntake(int intakeId) async {
    final retrievedIntakes = await dbHelper.getIntake(intakeId);
    return retrievedIntakes;
  }

// Update an Intakes object in the database
  void updateIntake({required int intakeId, required Intakes newIntake}) async {
    var retrievedIntakes = await dbHelper.getIntake(intakeId);
    retrievedIntakes?.breakfast = newIntake.breakfast;
    retrievedIntakes?.lunch = newIntake.lunch;
    retrievedIntakes?.dinner = newIntake.dinner;

    await dbHelper.updateIntake(retrievedIntakes!);
  }

// Delete an Intakes object from the database
  void deleteIntake(int intakeId) async {
    final deletedIntakeId = intakeId;
    await dbHelper.deleteIntake(deletedIntakeId);
  }
}
