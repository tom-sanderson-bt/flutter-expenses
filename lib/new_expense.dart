import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMMMd();

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.addExpense});

  final void Function(Expense) addExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  DateTime? _expenseDate;
  Category _expenseCategory = Category.food;

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _pickDate() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      _expenseDate = pickedDate;
    });
  }

  Future<void> _showErrorDialog() async {
    showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Unable to add item'),
            content: const Text(
                'Please check you have entered a title, amount, and selected a date'),
            actions: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text('Ok'),
              ),
            ],
          );
        });
  }

  void _addExpense() {
    var title = titleController.text.trim();
    var amount = double.tryParse(amountController.text);

    if (title == "" || amount == null || amount <= 0 || _expenseDate == null) {
      print(
          'show error $title, ${amountController.text} $amount, $_expenseDate');

      _showErrorDialog();
      return;
    }

    widget.addExpense(Expense(
        title: titleController.text,
        amount: amount,
        date: _expenseDate!,
        category: _expenseCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text("Title")),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: amountController,
                  maxLength: 15,
                  decoration: const InputDecoration(label: Text("Amount")),
                  keyboardType: TextInputType.number,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                  child: Row(
                children: [
                  Text(_expenseDate == null
                      ? "Select a date"
                      : formatter.format(_expenseDate!)),
                  IconButton(
                    onPressed: _pickDate,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              )),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                  value: _expenseCategory,
                  items: Category.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                  onChanged: (Category? value) {
                    if (value == null) return;
                    setState(() {
                      _expenseCategory = value;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              const SizedBox(width: 8),
              ElevatedButton(
                  onPressed: () {
                    _addExpense(); // Pass innerContext to the method
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text("Add expense")),
            ],
          )
        ],
      ),
    );
  }
}
