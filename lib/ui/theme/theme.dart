// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

final ThemeData LightTheme = ThemeData(
  primarySwatch: _createMaterialColor(Color(0xFFE0580C)),
  primaryColor: Color(0xFFE0580C),
  brightness: Brightness.light,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.montserrat(
      color: Color(0xFF3C3C3C),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.montserrat(
      color: Color(0xFF3C3C3C),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.montserrat(
      color: Color(0xFF3C3C3C),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: GoogleFonts.nunito(
      color: Color(0xFF3C3C3C),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.nunito(
      color: Color(0xFF3C3C3C),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.nunito(
      color: Color(0xFF3C3C3C),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFFFFFFF),
    foregroundColor: Color(0xFF3C3C3C),
    titleTextStyle: GoogleFonts.nunito(
        color: Color(0xFF3C3C3C), fontSize: 16, fontWeight: FontWeight.w600),
    centerTitle: true,
    elevation: 0.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white54;
          }
          return Colors.white;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Color(0xFFE0580C).withOpacity(0.5);
          }
          return Color(0xFFE0580C);
        },
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return GoogleFonts.nunito(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w600);
          }
          return GoogleFonts.nunito(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
      elevation: MaterialStateProperty.all(0.0),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(
      Color(0xFFE0580C),
    ),
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    textStyle: MaterialStateProperty.all(
      GoogleFonts.nunito(
          color: Color(0xFFE0580C), fontSize: 16, fontWeight: FontWeight.w600),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
    side: MaterialStateProperty.all(
      BorderSide(
        color: Color(0xFFE0580C),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xFFE0580C),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Colors.white,
    titleTextStyle: GoogleFonts.nunito(
        color: Color(0xFF3C3C3C), fontSize: 18, fontWeight: FontWeight.w700),
    contentTextStyle: GoogleFonts.nunito(
        color: Color(0xFF3C3C3C), fontSize: 14, fontWeight: FontWeight.w500),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0.0),
      foregroundColor: MaterialStateProperty.all(
        Color(0xFFE0580C),
      ),
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
);

final ThemeData DarkTheme = ThemeData(
  primarySwatch: _createMaterialColor(Color(0xFFE0580C)),
  primaryColor: Color(0xFFE0580C),
  brightness: Brightness.dark,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    headlineLarge: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headlineSmall: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    bodySmall: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 12,
      fontWeight: FontWeight.w500,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: Color(0xFFE3E3E3),
    titleTextStyle: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    centerTitle: true,
    elevation: 0.0,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white54;
          }
          return Colors.white;
        },
      ),
      backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Color(0xFFE0580C).withOpacity(0.5);
          }
          return Color(0xFFE0580C);
        },
      ),
      textStyle: MaterialStateProperty.resolveWith<TextStyle>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return GoogleFonts.nunito(
                color: Colors.white54,
                fontSize: 16,
                fontWeight: FontWeight.w600);
          }
          return GoogleFonts.nunito(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600);
        },
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      minimumSize: MaterialStateProperty.all(Size(double.infinity, 60)),
      elevation: MaterialStateProperty.all(0.0),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(
      Colors.white,
    ),
    backgroundColor: MaterialStateProperty.all(Colors.transparent),
    textStyle: MaterialStateProperty.all(
      GoogleFonts.nunito(
          color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
    ),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),
      ),
    ),
    side: MaterialStateProperty.all(
      BorderSide(
        color: Color(0xFFE0580C),
      ),
    ),
    minimumSize: MaterialStateProperty.all(Size(double.infinity, 50)),
  )),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: Color(0xFFE0580C),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Color(0xFF0C0C0C),
    titleTextStyle: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 18,
      fontWeight: FontWeight.w700,
    ),
    contentTextStyle: GoogleFonts.nunito(
      color: Color(0xFFE3E3E3),
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0.0),
      foregroundColor: MaterialStateProperty.all(
        Color(0xFFE0580C),
      ),
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      textStyle: MaterialStateProperty.all(
        GoogleFonts.nunito(fontSize: 14, fontWeight: FontWeight.w600),
      ),
    ),
  ),
  checkboxTheme: CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4),
    ),
  ),
  scaffoldBackgroundColor: Color(0xFF0C0C0C),
);
