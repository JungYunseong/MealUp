import 'package:flutter/material.dart';

class AddFoodTextField extends StatefulWidget {
  const AddFoodTextField({
    super.key,
    required this.controller,
    this.inputType,
    required this.onChanged,
    this.suffixIcon,
  });

  final Widget? suffixIcon;
  final TextEditingController controller;
  final TextInputType? inputType;
  final Function(String value) onChanged;

  @override
  State<AddFoodTextField> createState() => _AddFoodTextFieldState();
}

class _AddFoodTextFieldState extends State<AddFoodTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
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
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.inputType,
        textAlign: (widget.inputType != TextInputType.number)
            ? TextAlign.start
            : TextAlign.end,
        decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(20.0),
            suffixIcon: widget.suffixIcon),
        onChanged: (value) => widget.onChanged(value),
      ),
    );
  }
}
