import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/add_barcode_data_sheet.dart';
import 'package:meal_up/components/add_food_text_field.dart';
import 'package:meal_up/components/food_data_row.dart';
import 'package:meal_up/components/nutrition_text_field.dart';
import 'package:meal_up/firebase_service.dart';
import 'package:meal_up/model/food_item.dart';
import 'package:meal_up/model/nutrition.dart';
import 'package:meal_up/screens/barcode_scanner_screen.dart';
import 'package:meal_up/screens/search_api.dart';
import '../constant.dart';
import '../database_helper.dart';
import '../model/intakes.dart';

class AddFoodScreenArguments {
  final int id;
  final String date;
  final String mealTime;
  final Intakes? retrieveIntake;
  final Function() onDismiss;

  AddFoodScreenArguments({
    required this.id,
    required this.date,
    required this.mealTime,
    required this.retrieveIntake,
    required this.onDismiss,
  });
}

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({
    super.key,
    required this.id,
    required this.date,
    required this.mealTime,
    required this.retrieveIntake,
    required this.onDismiss,
  });

  final int id;
  final String date;
  final String mealTime;
  final Intakes? retrieveIntake;
  final Function() onDismiss;

  static String routeName = '/add_food_screen';

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  bool isLoading = false;

  TextEditingController nameController = TextEditingController();
  final TextEditingController carbController = TextEditingController();
  final TextEditingController proteinController = TextEditingController();
  final TextEditingController fatController = TextEditingController();
  String? thumbnail;

  void Function()? addFood;

  late final intake = widget.retrieveIntake;

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
        addFood = () async {
          await update();
          if (mounted) {
            Navigator.pop(context);
          }
        };
      });
    }
  }

  Future update() async {
    var retrievedIntakes = widget.retrieveIntake;
    if (retrievedIntakes == null) {
      await dbHelper.createIntake(
        Intakes(id: widget.id, date: widget.date),
      );
      retrievedIntakes = await dbHelper.getIntake(widget.id);
      await updateIntake(retrievedIntakes!);
      widget.onDismiss();
    } else {
      await updateIntake(retrievedIntakes);
      widget.onDismiss();
    }
  }

  Future updateIntake(Intakes retrievedIntakes) async {
    var updateIntake = retrievedIntakes;
    var type = '';
    switch (widget.mealTime) {
      case '아침':
        type = 'breakfast';
      case '점심':
        type = 'lunch';
      case '저녁':
        type = 'dinner';
    }
    final item = FoodItem(
      type: type,
      name: nameController.text,
      thumbnail: thumbnail,
      carb: double.parse(carbController.text).round(),
      protein: double.parse(proteinController.text).round(),
      fat: double.parse(fatController.text).round(),
    );

    switch (widget.mealTime) {
      case '아침':
        updateIntake.breakfast.add(item);
      case '점심':
        updateIntake.lunch.add(item);
      case '저녁':
        updateIntake.dinner.add(item);
    }

    await dbHelper.updateIntake(updateIntake);
  }

  Future<(String, String?, String, String, String)?> searchBarcode(
      {required String barcode}) async {
    final firebaseService = FirebaseService();
    final data = await firebaseService.searchBarcodeId(query: barcode);
    if (data != null) {
      final name = data['name'] as String;
      final thumbnail = data['thumbnail'] as String?;
      final carb = data['carb'] as String;
      final protein = data['protein'] as String;
      final fat = data['fat'] as String;
      return (name, thumbnail, carb, protein, fat);
    } else {
      return null;
    }
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
            child: BarcodeScannerScreen(
              onResult: (result) async {
                final data =
                    await searchBarcode(barcode: result.displayValue ?? '');
                if (data != null) {
                  setState(() {
                    nameController.text = data.$1;
                    thumbnail = data.$2;
                    carbController.text = data.$3;
                    proteinController.text = data.$4;
                    fatController.text = data.$5;
                  });
                } else {
                  if (!mounted) return;
                  addBarcodeData(context, barcodeId: result.displayValue!);
                }
              },
            ),
          ),
        );
      },
    );
  }

  void addBarcodeData(BuildContext context, {required String barcodeId}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: AddBarcodeDataSheet(
            barcodeId: barcodeId,
            tapAddButton: (name, carb, protein, fat) {
              setState(() {
                nameController.text = name;
                thumbnail = null;
                carbController.text = carb;
                proteinController.text = protein;
                fatController.text = fat;
              });
              validate();
            },
          ),
        );
      },
    );
  }

  void searchFood(BuildContext context, {required String query}) async {
    FocusManager.instance.primaryFocus?.unfocus();
    setState(() => isLoading = true);
    final api = SearchAPI();
    final result = await api.fetch(query);
    setState(() => isLoading = false);
    if (result.isNotEmpty && mounted) {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return FoodDataList(
            data: result,
            onSelect: (name, carb, protein, fat) {
              Navigator.pop(context);
              setState(() {
                nameController.text = name;
                thumbnail = null;
                carbController.text = carb;
                proteinController.text = protein;
                fatController.text = fat;
              });
              validate();
            },
          );
        },
      );
    } else {
      _showAlert();
    }
  }

  void _showAlert() {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text('검색 결과가 없습니다'),
            content: const Text('직접 식단정보를 입력해 주세요.'),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("확인"),
                  onPressed: () {
                    isLoading = false;
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
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
                                              searchFood(
                                                context,
                                                query: nameController.text,
                                              );
                                            }),
                                      ],
                                    ),
                                    onChanged: (value) {
                                      validate();
                                    }),
                              ),
                            ],
                          ),
                          const SizedBox(height: 27.0),
                          NutritionTextField(
                              nutrition: Nutrition.carbohydrate,
                              controller: carbController,
                              onChanged: (_) {
                                validate();
                              }),
                          NutritionTextField(
                              nutrition: Nutrition.protein,
                              controller: proteinController,
                              onChanged: (_) {
                                validate();
                              }),
                          NutritionTextField(
                              nutrition: Nutrition.fat,
                              controller: fatController,
                              onChanged: (_) {
                                validate();
                              }),
                          const Spacer(),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 0.0, 0.0, 16.0),
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
        ),
        if (isLoading)
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.4),
            child: Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }

  final dbHelper = DatabaseHelper.instance;

// Retrieve all Intakes objects from the database
  Future<Intakes?> retrieveIntake(int intakeId) async {
    final retrievedIntakes = await dbHelper.getIntake(intakeId);
    return retrievedIntakes;
  }

// Delete an Intakes object from the database
  void deleteIntake(int intakeId) async {
    final deletedIntakeId = intakeId;
    await dbHelper.deleteIntake(deletedIntakeId);
  }
}
