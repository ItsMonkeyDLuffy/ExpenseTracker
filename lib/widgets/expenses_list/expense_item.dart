import 'package:flutter/material.dart';
import 'package:fourthapp/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(context) {
    // card widget is displayed on the main screen as a elevated card with info
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // we can also use theme here (theme.of(Context)) to use the global text theme set in main.dart inside the text widget
            Text(
              expense.title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                //toStringAsFixed(2) here outputs double till 2 decimal places
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                const Spacer(), // takes all the left space b/w the above and below widgets
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(width: 8),
                    Text(expense.formattedDate),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
