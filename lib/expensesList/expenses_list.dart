import 'package:expenses/expensesList/expenses_item.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(this.expenses, {super.key, required this.onRemove});

  final List<Expense> expenses;

  final void Function(Expense) onRemove;

  @override
  Widget build(Object context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) => ExpensesItem(
          expenses[index],
          onRemove: onRemove,
        ),
      ),
    );
  }
}
