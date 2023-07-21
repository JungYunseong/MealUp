import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_up/components/add_food_text_field.dart';
import 'package:meal_up/components/nutrition_text_field.dart';
import 'package:meal_up/constant.dart';
import 'package:meal_up/model/nutrition.dart';

class AddBarcodeDataSheet extends StatefulWidget {
  const AddBarcodeDataSheet({
    super.key,
    required this.barcodeId,
    required this.tapAddButton,
  });

  final String barcodeId;
  final Function(String name, String carb, String protein, String fat)
      tapAddButton;

  @override
  State<AddBarcodeDataSheet> createState() => _AddBarcodeDataSheetState();
}

class _AddBarcodeDataSheetState extends State<AddBarcodeDataSheet> {
  bool isValid = false;
  void Function()? addBarcodeData;

  final nameController = TextEditingController();
  final carbController = TextEditingController();
  final proteinController = TextEditingController();
  final fatController = TextEditingController();

  void validate() {
    setState(() {
      if (nameController.text.isEmpty ||
          carbController.text.isEmpty ||
          proteinController.text.isEmpty ||
          fatController.text.isEmpty) {
        addBarcodeData = null;
        isValid = false;
      } else {
        isValid = true;
        addBarcodeData = () async {
          FirebaseService().addData(
            barcodeId: widget.barcodeId,
            thumbnail: null,
            name: nameController.text,
            carb: carbController.text,
            protein: proteinController.text,
            fat: fatController.text,
          );
          await widget.tapAddButton(nameController.text, carbController.text,
              proteinController.text, fatController.text);
          if (mounted) {
            Navigator.pop(context);
          }
        };
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CupertinoButton(
                    onPressed: null,
                    disabledColor: Colors.transparent,
                    child: Text(
                      '추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.transparent,
                        fontSize: 18,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Text(
                    '식단 정보 추가',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryTextColor,
                      fontSize: 18,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  CupertinoButton(
                    onPressed: addBarcodeData,
                    child: Text(
                      '추가',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isValid ? primaryColor : tertiaryColor,
                        fontSize: 18,
                        fontFamily: 'Noto Sans KR',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Text(
                    '"${widget.barcodeId}"에 대한 정보가 없습니다.\n해당 제품의 영양정보를 추가해 보세요.',
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                      fontFamily: 'Noto Sans KR',
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24.0),
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
                          onChanged: (value) {
                            validate();
                          },
                        ),
                      ),
                    ],
                  ),
                  NutritionTextField(
                    nutrition: Nutrition.carbohydrate,
                    controller: carbController,
                    onChanged: (value) {
                      validate();
                    },
                  ),
                  NutritionTextField(
                    nutrition: Nutrition.protein,
                    controller: proteinController,
                    onChanged: (value) {
                      validate();
                    },
                  ),
                  NutritionTextField(
                    nutrition: Nutrition.fat,
                    controller: fatController,
                    onChanged: (value) {
                      validate();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
