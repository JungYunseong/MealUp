import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import '../../model/gender.dart';

class GenderButton extends StatefulWidget {
  const GenderButton({
    super.key,
    required this.gender,
    required this.selectedGender,
    this.onTap,
  });

  final Function()? onTap;
  final Gender gender;
  final Gender selectedGender;

  @override
  State<GenderButton> createState() => _GenderButtonState();
}

class _GenderButtonState extends State<GenderButton> {
  @override
  Widget build(BuildContext context) {
    Color buttonColor =
        (widget.selectedGender == widget.gender) ? const Color(0xFF8C80F8) : Colors.white;
    Color textColor =
        (widget.selectedGender == widget.gender) ? Colors.white : const Color(0xFF4C5980);
    Color borderColor = Colors.transparent;

    return Bounceable(
      onTap: widget.onTap,
      child: Container(
        width: 150.0,
        height: 200.0,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(10.0),
          color: buttonColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              if (widget.gender == Gender.male)
                Image.asset('assets/icons/male.png', height: 110, fit: BoxFit.fitHeight,),
              if (widget.gender == Gender.female)
                Image.asset('assets/icons/female.png', height: 110, fit: BoxFit.fitHeight,),
              const SizedBox(height: 20.0),
              Text(
                widget.gender.convertToString,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: textColor,
                  fontFamily: 'Rubik',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
