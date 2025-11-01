import 'package:flutter/material.dart';
import 'package:flutter_app/models/expense.dart';
import 'package:flutter_app/pages/expense_form_page.dart';

class ExpenseListPage extends StatefulWidget {
  const ExpenseListPage({super.key});

  @override
  State<ExpenseListPage> createState() => _ExpenseListPageState();
}

class _ExpenseListPageState extends State<ExpenseListPage> {
  final List<Expense> _userExpenses = [
    Expense(
      id: 1,
      description: 'Coffee',
      amount: 3.50,
      date: DateTime(2025, 10, 29),
      category: 'Food',
    ),
    Expense(
      id: 2,
      description: 'Bus Ticket',
      amount: 2.00,
      date: DateTime(2025, 10, 30),
      category: 'Transport',
    ),
    Expense(
      id: 3,
      description: 'Book',
      amount: 15.00,
      date: DateTime(2025, 10, 31),
      category: 'Shopping',
    ),
  ];

  String _username = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args != null && args is String) {
        setState(() {
          _username = args;
        });
      }
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _openExpenseForm() async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseFormPage()),
    );

    if (newExpense != null && newExpense is Expense) {
      setState(() {
        _userExpenses.add(newExpense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Welcome, $_username'),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
              tooltip: 'Logout',
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: _userExpenses.length,
        itemBuilder: (context, index) {
          final expense = _userExpenses[index];
          return ListTile(
            title: Text(expense.description),
            subtitle: Text('${expense.amount}€ - ${expense.category}'),
            trailing: Text(expense.date.toString().split(' ')[0]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openExpenseForm,
        child: const Icon(Icons.add),
      ),
    );
  }
}
