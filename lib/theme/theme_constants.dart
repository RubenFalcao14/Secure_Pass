import 'package:flutter/material.dart';

const COLOUR_PRIMARY = Color.fromARGB(255, 179, 157, 219);
const COLOUR_ACCENT = Colors.deepPurple;

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: COLOUR_PRIMARY,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0,)  
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
        )
      ),
      backgroundColor: MaterialStateProperty.all<Color>(COLOUR_ACCENT),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.grey),
    thumbColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0,)  
      ),
      shape: MaterialStateProperty.all<OutlinedBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0,)
        )
      ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
      overlayColor: MaterialStateProperty.all<Color>(Colors.black26),
    ),
  ),
);