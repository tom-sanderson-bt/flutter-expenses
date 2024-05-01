import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMd();

class ExpensesItem extends StatefulWidget {
  const ExpensesItem(this.expense, {super.key, required this.onRemove});

  final Expense expense;

  final void Function(Expense) onRemove;

  @override
  State<ExpensesItem> createState() {
    return _ExpensesListState();
  }
}

class _ExpensesListState extends State<ExpensesItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Dismissible(
        key: Key(widget.expense.id),
        onDismissed: (direction) => {
          widget.onRemove(
            widget.expense,
          ),
        },
        direction: DismissDirection.endToStart,
        background: Container(
          color: Theme.of(context).colorScheme.error,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.expense.title,
                ),
              ),
              Row(children: [
                Icon(categoryIcons[widget.expense.category]),
                const SizedBox(width: 10),
                Text('£${widget.expense.amount.toStringAsFixed(2)}'),
                const SizedBox(width: 10),
                Text(formatter.format(widget.expense.date)),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
