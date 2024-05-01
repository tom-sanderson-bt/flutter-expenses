import 'package:expenses/expenses.dart';
import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 10, 140, 130),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: Typography.blackHelsinki,
      ),
      home: const Expenses(),
    ),
  );
}
