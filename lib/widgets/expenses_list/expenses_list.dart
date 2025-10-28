import 'package:flutter/material.dart';
import 'package:fourthapp/models/expense.dart';
import 'package:fourthapp/widgets/expenses_list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(context) {
    // listview is just like column + it is already scrollable and can view multiple list objects and .builder below helps in optimizing large/dynamic lists
    return ListView.builder(
      itemCount: expenses.length,
      // Dismissable used for swipe deleting the widgets
      itemBuilder: (context, index) => Dismissible(
        // ValueKey creates a key for widget identification which is necessery in some widgets like here in dismissable
        key: ValueKey(expenses[index]),
        background: Container(
          // theme.of(context) used to use the set values in themeData in main.dart
          color: Theme.of(context).colorScheme.error,
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direction) => onRemoveExpense(expenses[index]),
        child: ExpenseItem(expenses[index]),
      ), // itemBuilder runs for each item at given index
    );
  }
}
