import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/add_food_text_field.dart';
import 'package:meal_up/model/nutrition.dart';
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
  String? foodName;
  int? carb;
  int? protein;
  int? fat;

  TextEditingController nameController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();

  void Function()? addFood;

  void validate() {
    if (nameController.text == '' ||
        carbController.text == '' ||
        proteinController.text == '' ||
        fatController.text == '') {
      setState(() {
        addFood = null;
      });
    } else {
      setState(() {
        addFood = () {
          print('식단 추가');
        };
      });
    }
  }

  Widget nutritionTextField({
    required Nutrition nutrition,
    required Function(String value) onChanged,
  }) {
    TextEditingController controller = TextEditingController();
    switch (nutrition) {
      case Nutrition.carbohydrate:
        controller = carbController;
      case Nutrition.protein:
        controller = proteinController;
      case Nutrition.fat:
        controller = fatController;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 90.0,
            child: Row(
              children: [
                Container(
                  width: 13.95,
                  height: 16,
                  decoration: ShapeDecoration(
                    color: nutrition.getColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Text(
                  nutrition.convertToString,
                  style: const TextStyle(
                    color: Color(0xFF2D3142),
                    fontSize: 16,
                    fontFamily: 'Noto Sans KR',
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.23,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: 90.0,
            child: AddFoodTextField(
              controller: controller,
              inputType: TextInputType.number,
              onChanged: onChanged,
            ),
          ),
          const SizedBox(width: 8.0),
          const Text(
            'g',
            style: TextStyle(
              color: Color(0xFF2D3142),
              fontSize: 16,
              fontFamily: 'Rubik',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.23,
            ),
          )
        ],
      ),
    );
  }

  void scanBarcode(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.82,
            child: BarcodeScannerScreen(onResult: (result) {
              setState(() {
                nameController.text = result.displayValue ?? '';
              });
            },),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        decoration: backgroundGradient,
        child: Scaffold(
          appBar: const CupertinoNavigationBar(
            middle: Text(
              '식단 추가',
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
                      Row(
                        children: [
                          const Text(
                            '식단 이름',
                            style: TextStyle(
                              color: Color(0xFF2D3142),
                              fontSize: 16,
                              fontFamily: 'Noto Sans KR',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.23,
                            ),
                          ),
                          const SizedBox(width: 16.0),
                          Expanded(
                            child: AddFoodTextField(
                                controller: nameController,
                                suffixIcon: Wrap(
                                  children: [
                                    CupertinoButton(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 12.0, 0.0, 12.0),
                                        child: Image.asset(
                                          'assets/icons/scan.png',
                                          width: 24.0,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        onPressed: () {
                                          scanBarcode(context);
                                        }),
                                    CupertinoButton(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 12.0, 12.0, 12.0),
                                        child: const Icon(
                                          CupertinoIcons.search,
                                          color: secondaryColor,
                                          size: 24.0,
                                        ),
                                        onPressed: () {
                                          print('식단 검색');
                                        }),
                                  ],
                                ),
                                onChanged: (value) {
                                  validate();
                                  foodName = value;
                                }),
                          ),
                        ],
                      ),
                      const SizedBox(height: 27.0),
                      nutritionTextField(
                        nutrition: Nutrition.carbohydrate,
                        onChanged: (value) {
                          validate();
                          if (value.isNotEmpty) {
                            carb = int.parse(value);
                          }
                        },
                      ),
                      nutritionTextField(
                        nutrition: Nutrition.protein,
                        onChanged: (value) {
                          validate();
                          if (value.isNotEmpty) {
                            protein = int.parse(value);
                          }
                        },
                      ),
                      nutritionTextField(
                        nutrition: Nutrition.fat,
                        onChanged: (value) {
                          validate();
                          if (value.isNotEmpty) {
                            fat = int.parse(value);
                          }
                        },
                      ),
                      const Spacer(),
                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: CupertinoButton(
                            color: primaryColor,
                            disabledColor: tertiaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            onPressed: addFood,
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  '식단 추가하기',
                                  style: buttonText,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
