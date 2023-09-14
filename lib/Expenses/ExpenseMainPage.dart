import 'package:flutter/material.dart';
import 'package:SuperMarket/Expenses/ExpenseMonthlySubForm.dart';
import 'package:SuperMarket/Expenses/ExpenseSubForm.dart';
import 'package:SuperMarket/Expenses/ExpenseWeeklySubForm.dart';
import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ExpensePage(),
    );
  }
}

class ExpensePage extends StatefulWidget {
  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  @override
  void initState() {
    super.initState();
    fetchTotalSalesExpenses();
    fetchTotalExpenseThisWeek();
    fetchTotalExpenseThisMonth();
  }

  int totalSalesExpenses = 0;

  Future<void> fetchTotalSalesExpenses() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/expense/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var ExpenseAmountToday = data['expense_amount_today'];
      double Expenseamount = ExpenseAmountToday as double;
      totalSalesExpenses = Expenseamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalSalesExpenses = totalSalesExpenses;
      });
    }
  }

  int totalExpenseCurrentWeek = 0;

  Future<void> fetchTotalExpenseThisWeek() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/expense/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var ExpenseAmountWeek = data['expense_amount_current_week'];
      double ExpenseWeekamount = ExpenseAmountWeek as double;
      totalExpenseCurrentWeek = ExpenseWeekamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalExpenseCurrentWeek = totalExpenseCurrentWeek;
      });
    }
  }

  int totalExpenseAmountThisMonth = 0;

  Future<void> fetchTotalExpenseThisMonth() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/expense/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var ExpenseAmountMonth = data['expense_amount_current_month'];
      double ExpenseMonthamount = ExpenseAmountMonth as double;
      totalExpenseAmountThisMonth = ExpenseMonthamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalExpenseAmountThisMonth = totalExpenseAmountThisMonth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  color: Colors.black,
                ),
              ],
            ),
            // Section 1: Header
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Today Expenses',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),

            // Section 2: Image
            Container(
              width: 150.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 113, 153),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/bill_sales.png', // Replace with your image asset
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 224, 234, 240)), // Custom color
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TodaySaleExpensePage()));
                    },
                    child: Text(
                      '₹ $totalSalesExpenses .0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Current Week Expenses',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 150.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 113, 153),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/bill_sales.png', // Replace with your image asset
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 224, 234, 240)), // Custom color
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeekExpensePage()));
                    },
                    child: Text(
                      '₹ $totalExpenseCurrentWeek .0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  'Current Month Expenses',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              width: 150.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 64, 113, 153),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/bill_sales.png', // Replace with your image asset
                      height: 50,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 224, 234, 240)), // Custom color
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonthlyExpensePage()));
                    },
                    child: Text(
                      '₹ $totalExpenseAmountThisMonth .0',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            // Section 3: Text

            // Section 4: Buttons

            // Section 5: Footer
          ],
        ),
      ),
    );
  }
}
