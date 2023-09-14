import 'package:flutter/material.dart';
import 'package:SuperMarket/Expenses/ExpenseMainPage.dart';
import 'package:SuperMarket/Purchase/PurchaseMain.dart';
import 'package:SuperMarket/Sales/SalesMainPage.dart';
import 'package:SuperMarket/SmartReport/SmartMainPage.dart';
import 'package:SuperMarket/Stock%20Page/StockMainPage.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:SuperMarket/screens/dashboard/dashboard_screen.dart';

class BottomSidemenu extends StatefulWidget {
  const BottomSidemenu({Key? key}) : super(key: key);

  @override
  State<BottomSidemenu> createState() => _BottomSidemenuState();
}

class _BottomSidemenuState extends State<BottomSidemenu> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    DashboardScreen(),
    SalesPage(),
    PurchasePage(),
    CatNameScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _pages[_currentIndex],
          ),
          // Conditionally show the BottomNavigationBar in mobile view
          if (Responsive.isMobile(context))
            Container(
              color: Colors.white, // Customize the background color
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(0, Icons.dashboard, 'Dashboard'),
                  _buildNavItem(1, Icons.shopify, 'Sales'),
                  _buildNavItem(2, Icons.shopping_cart, 'Purchase'),
                  _buildNavItem(3, Icons.production_quantity_limits, 'Stock'),
                  PopupMenuButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    color: Colors.white,
                    icon: Icon(
                      Icons.menu,
                      color: Colors.black,
                    ),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "Smart Report",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text(
                          "Expenses",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                        value: 1,
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SmartPage()),
                        );
                      }
                      if (value == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpensePage()),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = index == _currentIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Color.fromARGB(255, 64, 113, 153) : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: isSelected ? 12 : 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
