import 'package:flutter/material.dart';

class NecromancerTheme {
  // Define our refined color palette
  static const Color darkGreen = Color(0xFF062F19);
  static const Color mediumGreen = Color(0xFF1C4B30);
  static const Color lightGreen = Color(0xFF466D55);
  static const Color darkGray = Color(0xFF344038);
  static const Color boneColor = Color(0xFFDDDBBE);
  static const Color blackColor = Color(0xFF121212);
  static const Color greyColor = Color(0xFF424242);
  static const Color lightGreyColor = Color(0xFF616161);
  static const Color purpleAccent = Color(0xFF7C4DFF);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: darkGreen,
      scaffoldBackgroundColor: blackColor,
      colorScheme: ColorScheme.dark(
        primary: mediumGreen,
        secondary: purpleAccent,
        surface: greyColor,
        background: blackColor,
        error: Colors.redAccent,
        onPrimary: boneColor,
        onSecondary: boneColor,
        onSurface: boneColor,
        onBackground: boneColor,
      ),
      textTheme: TextTheme(
        headlineMedium: TextStyle(
          color: boneColor,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(color: boneColor),
        bodyMedium: TextStyle(color: boneColor.withOpacity(0.9)),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: blackColor,
        foregroundColor: boneColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: mediumGreen,
          foregroundColor: boneColor,
          disabledBackgroundColor: darkGray,
          disabledForegroundColor: lightGreyColor,
        ),
      ),
      iconTheme: IconThemeData(
        color: purpleAccent,
      ),
      cardTheme: CardTheme(
        color: greyColor,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: darkGray,
      ),
      dividerColor: lightGreen,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: purpleAccent,
        foregroundColor: boneColor,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: blackColor,
        selectedItemColor: purpleAccent,
        unselectedItemColor: lightGreyColor,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return purpleAccent;
          }
          return boneColor;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return purpleAccent.withOpacity(0.5);
          }
          return lightGreyColor;
        }),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return purpleAccent;
          }
          return lightGreyColor;
        }),
        checkColor: MaterialStateProperty.all(boneColor),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return purpleAccent;
          }
          return lightGreyColor;
        }),
      ),
    );
  }
}
