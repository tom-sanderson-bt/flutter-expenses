import 'package:expenses/chart/chart.dart';
import 'package:expenses/expensesList/expenses_list.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void removeExpense(Expense expense) {
    var index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${expense.title} dismissed'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          }),
    ));
  }

  void openAddExpenses() {
    showModalBottomSheet(
        context: context,
        builder: ((ctx) => NewExpense(addExpense: addExpense)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box_outlined),
            onPressed: openAddExpenses,
          )
        ],
      ),
      body: Column(
        children: [
          Chart(
            expenses: _registeredExpenses,
          ),
          ExpensesList(
            _registeredExpenses,
            onRemove: removeExpense,
          )
        ],
      ),
    );
  }
}
