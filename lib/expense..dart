import 'package:expense_calculator/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_calculator/model/expense_model.dart';
import 'package:expense_calculator/widgets/expense_list.dart';
import 'package:expense_calculator/widgets/new_expense.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  double totalexpense = 0.00;
  double totalincome = 0.00;

  List<Expense1> registeredexpenses = [];

  void _openaddexpenseoverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Newexpense(
              addexpense: addexpense,
            ));
  }

  void addexpense(Expense1 expense) {
    setState(() {
      registeredexpenses.add(expense);
      if (expense.inorout == Inorout.cashin) {
        totalincome += expense.amount;
      } else {
        totalexpense += expense.amount;
      }
    });
  }

  void removeexpense(Expense1 expense) {
    final expenseindex = registeredexpenses.indexOf(expense);
    setState(() {
      registeredexpenses.remove(expense);
      if (expense.inorout == Inorout.cashin) {
        totalincome -= expense.amount;
      } else {
        totalexpense -= expense.amount;
      }
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted"),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              registeredexpenses.insert(expenseindex, expense);
            });
          }),
    ));
  }

  void deleteeverything() {
    registeredexpenses.isNotEmpty
        ? setState(() {
            showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                      content: const Text("Delete all?"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              setState(() {
                                registeredexpenses = [];
                                totalexpense = 0;
                                totalincome = 0;
                              });
                            },
                            child: const Text("delete")),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("cancel"))
                      ],
                    ));
          })
        : setState(() {
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("No expenses to delete"),
              duration: Duration(seconds: 1),
            ));
          });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    //print(width);

    Widget maincontent = const Center(
      child: Text("No expenses,try adding some."),
    );

    if (registeredexpenses.isNotEmpty) {
      maincontent = Expanded(
          child: Expenselist(
        expenses: registeredexpenses,
        removeexpense: removeexpense,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Calculator'),
        actions: [
          IconButton(
              onPressed: deleteeverything, icon: const Icon(Icons.delete)),
          IconButton(
              onPressed: _openaddexpenseoverlay, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 12),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Chart(expenses: registeredexpenses),
                  const SizedBox(
                    height: 10,
                  ),
                  maincontent,
                  registeredexpenses.isEmpty
                      ? const Spacer()
                      : const SizedBox(
                          height: 1,
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Total expense:$totalexpense",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 94, 163, 193))),
                      const SizedBox(
                        width: 20,
                      ),
                      Text("Total income:$totalincome",
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 94, 163, 193))),
                    ],
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(child: Chart(expenses: registeredexpenses)),
                      registeredexpenses.isEmpty
                          ? Expanded(child: maincontent)
                          : maincontent
                    ],
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total expense:$totalexpense",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 94, 163, 193))),
                    const SizedBox(
                      width: 20,
                    ),
                    Text("Total income:$totalincome",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 94, 163, 193))),
                  ],
                )
              ],
            ),
    );
  }
}
