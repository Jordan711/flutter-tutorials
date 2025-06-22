import 'package:flutter/material.dart';
import 'package:ppp/widgets/expenses_list/expenses_list.dart';
import 'package:ppp/models/expense.dart';
import 'package:ppp/widgets/new_expense.dart';
import 'package:ppp/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
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

  void _openAddExpenseOverlay() {
    // Context is the current widget meta data, information on relation to other widgets
    showModalBottomSheet(
      useSafeArea: true, // Done by default on a Scaffold widget
      isScrollControlled:
          true, // The modal overlay will take full available height
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpense),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // build method gets run again when portrait switched to landscape and etc
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);

    final width = MediaQuery.of(context).size.width;

    Widget mainContent = Center(
      child: Text('No expenses found. Start adding some!'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body:
          width < 600
              ? Column(
                children: [
                  Chart(expenses: _registeredExpenses),
                  Expanded(child: mainContent),
                ],
              )
              : Row(
                children: [
                  // Expanded constaints the child to only take as much width as
                  // available in the Row after sizing the other Row children
                  /**
                   * Widgets get sized based on their size preferences and parent widget size constraints
                   * 
                   * Column Preferences - height: as much as possible, width: as much as needed by children
                   * Scaffold Constraints - height: max device height, width: max device width
                   * 
                   * If a Column is placed inside a Scaffold
                   * height: max device height
                   * width: depnds on children
                   * 
                   * Constraints of the parent widget overrides the preferences of the child widget
                   * 
                   * Column does not pass any height constraints to its child widgets
                   * 
                   * Expanded does set height constraints , sets child height to the maximum avaialble height
                   * instead of getting as much height as possible, i.e. infinity
                   * 
                   * Wrapping unconstrained widgets eith Expanded makes sure that unconstrained widgets inside 
                   * of other unconstrained widgets e.g. ListView inside of Column
                   * doesn't cause problems
                   */
                  Expanded(child: Chart(expenses: _registeredExpenses)),
                  Expanded(child: mainContent),
                ],
              ),
    );
  }
}
