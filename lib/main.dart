import 'package:flutter/material.dart';
import 'package:expense_calculator/expense..dart';

var kcolorscheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(122, 96, 149, 172));

var kdarkcolor = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(223, 5, 128, 79),
    brightness: Brightness.dark);
void main() {
  runApp(MaterialApp(
    darkTheme: ThemeData.dark().copyWith(
      useMaterial3: true,
      colorScheme: kdarkcolor,
    ),
    theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kcolorscheme,
        appBarTheme: const AppBarTheme().copyWith(
            backgroundColor: kcolorscheme.onPrimaryContainer,
            foregroundColor: kcolorscheme.primaryContainer),
        cardTheme: const CardTheme().copyWith(
            color: kcolorscheme.secondaryContainer,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                backgroundColor: kcolorscheme.primaryContainer)),
        textTheme: ThemeData().textTheme.copyWith(
                titleLarge: TextStyle(
              color: kcolorscheme.onSecondaryContainer,
              fontSize: 16,
            ))),
    themeMode: ThemeMode.system,
    home: const Expense(),
  ));
}
