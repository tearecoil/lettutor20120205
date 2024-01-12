import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  colorScheme: const ColorScheme.light(
    primary: Colors.black,
    error: Colors.red,
  ),
  canvasColor: Colors.white,
  useMaterial3: true,
  primaryColor: Colors.blue[600],
  primarySwatch: Colors.blue,
  hintColor: Colors.grey.shade600,
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.grey.shade400,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.blue[600],
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Colors.blue[600],
    ),
    displaySmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey[800],
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.black),
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    surfaceTintColor: Colors.grey.shade50,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    surfaceTintColor: Colors.grey.shade100,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.shade800,
  ),
  cardColor: Colors.grey.shade100,
  cardTheme: CardTheme(
    surfaceTintColor: Colors.grey.shade100,
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
      side: const MaterialStatePropertyAll(BorderSide(color: Colors.blue)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
  ),
);

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey.shade900,
  colorScheme: const ColorScheme.dark(
    primary: Colors.white,
    error: Colors.red,
  ),
  canvasColor: Colors.white.withOpacity(0.2),
  useMaterial3: true,
  primaryColor: Colors.blue[300],
  primarySwatch: Colors.blue,
  hintColor: Colors.grey.shade400,
  appBarTheme: AppBarTheme(
    surfaceTintColor: Colors.grey.shade900,
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      color: Colors.blue[600],
    ),
    displayMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: Colors.blue[600],
    ),
    displaySmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
    ),
    bodyLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.grey[200],
    ),
  ),
  dropdownMenuTheme: const DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
  ),
  dialogTheme: DialogTheme(
    surfaceTintColor: Colors.grey.shade500,
  ),
  bottomAppBarTheme: BottomAppBarTheme(
    surfaceTintColor: Colors.grey.shade900,
  ),
  iconTheme: IconThemeData(
    color: Colors.grey.shade200,
  ),
  cardColor: Colors.grey.shade900,
  cardTheme: CardTheme(
    surfaceTintColor: Colors.grey.shade200.withOpacity(0.2),
  ),
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.blue),
      side: const MaterialStatePropertyAll(BorderSide(color: Colors.blue)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(Colors.white),
      backgroundColor: MaterialStateProperty.all(Colors.blue),
    ),
  ),
  checkboxTheme: const CheckboxThemeData(
    side: BorderSide(color: Colors.grey),
  ),
);
