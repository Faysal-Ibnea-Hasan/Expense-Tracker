import 'package:expense_tracker/widgets/statefull/expense.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Expense(),
    ),
  );
}