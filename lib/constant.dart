import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0xFF7265E3);
const secondaryColor = Color(0xFF8C80F8);
const tertiaryColor = Color(0xFFE4DFFF);
const primaryTextColor = Color(0xFF2D3142);
const secondaryTextColor = Color(0xFF4C5980);

// Presets
var backgroundGradient = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF0F5FF),
      Color(0xFFFFFFFF),
    ],
  ),
);

// Text Styles
var onboardingTitle = const TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w500,
  color: primaryTextColor,
  fontFamily: 'Rubik',
);
var onboardingContents = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: secondaryTextColor,
  fontFamily: 'Noto Sans KR',
);
var buttonText = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontFamily: 'Noto Sans KR',
);
var aiStepText = const TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  color: primaryColor,
  fontFamily: 'Rubik',
);
var aiTitleText = const TextStyle(
  fontSize: 24.0,
  fontWeight: FontWeight.w500,
  color: primaryTextColor,
  fontFamily: 'Noto Sans KR',
);
var aiContentText = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w400,
  color: Color(0xFF4C5980),
  fontFamily: 'Noto Sans KR',
);
var carouselCardTitle = const TextStyle(
  fontSize: 18.0,
  fontWeight: FontWeight.w500,
  color: Color(0xFF2D3142),
  fontFamily: 'Noto Sans KR',
);
var carouselCardContents = const TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  color: Color(0xFF4C5980),
  fontFamily: 'Rubik',
);
var navTitle = const TextStyle(
  fontSize: 16.0,
  fontWeight: FontWeight.w600,
  color: Colors.white,
  fontFamily: 'Noto Sans KR',
);

// DatePicker
const TextStyle defaultDateTextStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontFamily: 'Rubik',
);
const TextStyle defaultDayTextStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  color: Color(0xFFE4DFFF),
  fontFamily: 'Rubik',
);
const TextStyle selectedDateStyle = TextStyle(
  fontSize: 14.0,
  fontWeight: FontWeight.w500,
  color: primaryColor,
  fontFamily: 'Rubik',
);
const TextStyle selectedDayStyle = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w500,
  color: Colors.white,
  fontFamily: 'Rubik',
);