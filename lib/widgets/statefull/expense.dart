import 'package:expense_tracker/models/expenses.dart';
import 'package:expense_tracker/widgets/statefull/expense_overlay.dart';
import 'package:expense_tracker/widgets/stateless/expense_list.dart';
import 'package:flutter/material.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});
  @override
  State<Expense> createState() {
    return _ExpenseState();
  }
}

class _ExpenseState extends State<Expense> {
  final List<Expenses> _registeredExpenses = [
    Expenses(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expenses(
      title: 'Movie',
      amount: 15.99,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => ExpenseOverlay(onAddExpenses: _addExpense),
    );
  }

  void _addExpense(Expenses expenses) {
    setState(() {
      _registeredExpenses.add(expenses);
    });
  }

  void _removeExpense(Expenses expenses) {
    final expenseIndex = _registeredExpenses.indexOf(expenses);
    setState(() {
      _registeredExpenses.remove(expenses);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: 'Undo',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expenses);
              });
            }),
        content: const Text('Expense deleted'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text(
        'No expenses found',
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}
