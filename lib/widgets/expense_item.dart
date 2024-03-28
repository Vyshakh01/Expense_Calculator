import 'package:flutter/material.dart';
import 'package:expense_calculator/model/expense_model.dart';

class Expenseitem extends StatelessWidget {
  const Expenseitem(this.expense, {super.key});
  final Expense1 expense;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: expense.inorout == Inorout.cashin
          ? Color.fromARGB(226, 76, 175, 79)
          : Color.fromARGB(244, 244, 67, 54),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 3,
            ),
            Row(children: [
              Text('\$${expense.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(icons_[expense.category]),
                  const SizedBox(width: 8),
                  Text(expense.formatteddate.toString()),
                ],
              )
            ]),
          ],
        ),
      ),
    );
  }
}
