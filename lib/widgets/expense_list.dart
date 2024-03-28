//import 'package:expense_calculator/expense..dart';
import 'package:expense_calculator/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:expense_calculator/widgets/expense_item.dart';

class Expenselist extends StatelessWidget {
  const Expenselist(
      {required this.expenses, super.key, required this.removeexpense});
  final void Function(Expense1 expense) removeexpense;
  final List<Expense1> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
              color: const Color.fromARGB(73, 87, 115, 144),
              margin: Theme.of(context).cardTheme.margin,
            ),
            onDismissed: (direction) {
              removeexpense(expenses[index]);
            },
            child: Expenseitem(expenses[index])));
  }
}
