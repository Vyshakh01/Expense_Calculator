import 'package:expense_calculator/model/expense_model.dart';
import 'package:flutter/material.dart';

class Newexpense extends StatefulWidget {
  const Newexpense({super.key, required this.addexpense});

  final void Function(Expense1 expense) addexpense;

  @override
  State<Newexpense> createState() => NewexpenseState();
}

class NewexpenseState extends State<Newexpense> {
  final _titlecontroller = TextEditingController();

  final _amountcontroller = TextEditingController();
  Category selectedCategory = Category.leisure;
  Inorout selectedInorout = Inorout.cashout;

  DateTime? _selecteddate = DateTime.now();

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void datepicking() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 8, now.month, now.day);
    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);
    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void submitexpense() {
    final enteredamount = double.tryParse(_amountcontroller.text);
    final isamountinvaild = enteredamount == null || enteredamount <= 0;

    if (_titlecontroller.text.trim().isEmpty ||
        isamountinvaild ||
        _selecteddate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("invalid input"),
                content: const Text("Enter valid data"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text("okay"))
                ],
              ));
      return;
    }

    widget.addexpense(Expense1(
        title: _titlecontroller.text,
        amount: enteredamount,
        date: _selecteddate!,
        category: selectedCategory,
        inorout: selectedInorout));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            decoration: const InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          const SizedBox(
            height: 3,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  decoration: const InputDecoration(
                      prefixText: "\$ ", label: Text("Enter amount ")),
                  keyboardType: TextInputType.number,
                  maxLength: 5,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(_selecteddate == null
                        ? 'no date entered'
                        : formatter.format(_selecteddate!)),
                    IconButton(
                        onPressed: datepicking,
                        icon: const Icon(Icons.calendar_month)),
                  ],
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButton(
                  value: selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase())))
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      selectedCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: submitexpense, child: const Text("Save expense")),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          ),
          Row(
            children: [
              DropdownButton(
                value: selectedInorout,
                items: Inorout.values
                    .map((inorout) => DropdownMenuItem(
                        value: inorout,
                        child: Text(inorout.name.toUpperCase())))
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    selectedInorout = value;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
