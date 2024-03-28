import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uid = Uuid();

final formatter = DateFormat.yMd();

enum Category { leisure, food, travel, other }

enum Inorout { cashin, cashout }

const icons_ = {
  Category.leisure: Icons.movie,
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
};

class Expense1 {
  Expense1(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category,
      required this.inorout})
      : id = uid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  final Inorout inorout;

  String get formatteddate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.expenses, required this.category});
  final Category category;
  final List<Expense1> expenses;

  ExpenseBucket.forCategory(List<Expense1> allexpenses, this.category)
      : expenses = allexpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
