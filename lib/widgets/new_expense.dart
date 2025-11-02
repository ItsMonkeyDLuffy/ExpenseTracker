import 'package:flutter/cupertino.dart'; // cupertino refers to ios styling and behaviours.
import 'package:flutter/material.dart';
import 'package:fourthapp/models/expense.dart';
import 'dart:io';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  // A TextEditingController is an object that controls and reads the text inside a TextField
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category? _selectedCategory;

  // async/await used in future values just like below to get hold of the value that would be selected in this case date.
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    // showDatePicker is a future type
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    // platform. is used to tell if the platform is ios or android to make adaptive apps
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: Text('Invalid Input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text(
            'Please make sure a valid title, amount, date and category was entered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  void _sumbitExpenseData() {
    // double.tryParse converts string to double and returns null if it fails
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || //trim excludes any white spaces
        amountIsInvalid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      _showDialog(); // show error message
      return;
    } else {
      final newExpense = Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!, // ! tells dart that this value wont be null
        category: _selectedCategory!,
      );
      // widget. used to access properties of stateful widget
      widget.onAddExpense(newExpense);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    // viewInsets gives info about any ui elements overlapping
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    // could have also used the same mediaquery.of().size way but this is a new approach using layoutBuilder
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;
        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            // can also use onChanged instead of controller to save the input title
                            controller: _titleController,
                            maxLength: 50,
                            decoration: InputDecoration(label: Text('Title')),
                          ),
                        ),

                        const SizedBox(width: 24),

                        Expanded(
                          child: TextField(
                            // can also use onChanged instead of controller to save the input title
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$ ',
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    //TextField is the UI widget that lets the user type input on screen — like name, email, password, etc.
                    TextField(
                      // can also use onChanged instead of controller to save the input title
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(label: Text('Title')),
                    ),

                  if (width >= 600)
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: DropdownButton(
                            value: _selectedCategory,
                            hint: Text('Category'),
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            // can also use onChanged instead of controller to save the input title
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              label: Text('Amount'),
                              prefixText: '\$ ',
                            ),
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _selectedDate == null
                                    ? 'No Date Selected'
                                    : formatter.format(_selectedDate!),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),

                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _sumbitExpenseData,
                          child: Text(
                            'Save Expense',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        SizedBox(
                          width: 120,
                          child: DropdownButton(
                            value: _selectedCategory,
                            hint: Text('Category'),
                            items: Category.values
                                .map(
                                  (category) => DropdownMenuItem(
                                    value: category,
                                    child: Text(category.name.toUpperCase()),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _sumbitExpenseData,
                          child: Text(
                            'Save Expense',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
