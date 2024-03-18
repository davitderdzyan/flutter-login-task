import 'package:flutter/material.dart';

final ThemeData myTheme = ThemeData(
  primaryColor: const Color(0xFF161616),
  secondaryHeaderColor: const Color(0xFFE3AC9A),
  hintColor: const Color(0xFFCCCCCC),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          return Color(0xFF161616).withOpacity(0.2);
        },
      ),
    ),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontFamily: 'Roboto'),
    labelLarge: TextStyle(
      fontFamily: 'Roboto',
      color: Color(0xFFE3AC9A),
      fontWeight: FontWeight.bold,
    ),
    displayLarge: TextStyle(
        fontSize: 24, fontFamily: 'Roboto', fontWeight: FontWeight.bold),
  ),
);
