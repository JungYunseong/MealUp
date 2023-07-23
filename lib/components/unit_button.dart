import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:meal_up/model/unit.dart';

class UnitButton extends StatefulWidget {
  const UnitButton({
    super.key,
    required this.unit,
    required this.selectedUnit,
    this.onTap,
  });

  final Function()? onTap;
  final Unit unit;
  final Unit selectedUnit;

  @override
  State<UnitButton> createState() => _UnitButtonButtonState();
}

class _UnitButtonButtonState extends State<UnitButton> {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = (widget.selectedUnit == widget.unit)
        ? const Color(0xFF8C80F8)
        : Colors.white;
    Color textColor = (widget.selectedUnit == widget.unit)
        ? Colors.white
        : const Color(0xFF4C5980);
    Color borderColor = Colors.transparent;

    return Bounceable(
      onTap: widget.onTap,
      child: Container(
        width: 94.0,
        height: 54.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10.0),
          color: buttonColor,
        ),
        child: Center(
          child: Text(
            widget.unit.convertToString,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: textColor,
              fontFamily: 'Rubik',
            ),
          ),
        ),
      ),
    );
  }
}
