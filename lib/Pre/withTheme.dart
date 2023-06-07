import 'package:flutter/material.dart';

class ThemeService {
  static Color get primary => Colors.deepPurple;

  static ThemeData light(BuildContext context) => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: primary),
        useMaterial3: true,
        appBarTheme: AppBarTheme(color: primary, foregroundColor: Colors.white),
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(width: 3, color: primary.withOpacity(0.5)),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black.withOpacity(0.3))),
        ),
      );
}
