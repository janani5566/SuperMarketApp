import 'package:SuperMarket/Purchase/CurrentWeekPurchase.dart';
import 'package:SuperMarket/Purchase/LastMonthPurchaseSubForm.dart';
import 'package:SuperMarket/Purchase/LastWeekPurchaseSubForm.dart';
import 'package:SuperMarket/Purchase/PurchaseSubFormdetail.dart';
import 'package:SuperMarket/Purchase/my_tab.dart';
import 'package:SuperMarket/Purchase/PurchaseBill.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:SuperMarket/screens/main/components/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'CurrentMonthPurchaseSubForm.dart';
import 'package:SuperMarket/IpAddress/database_helper.dart';

class PurchasePage extends StatefulWidget {
  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  void initState() {
    super.initState();
    fetchTodayPurchaseBill();
  }

  // my tabs
  List<Widget> myTabs = const [
    // donut tab
    MyTab(
      title: 'Purchase',
      iconPath: 'assets/images/payment.png',
    ),

    // burger tab
    // MyTab(
    //   title: 'Bills',
    //   iconPath: 'assets/images/shopping_sales.png',
    // ),

    // smoothie tab
    MyTab(
      title: 'Current\nWeek',
      iconPath: 'assets/images/products.png',
    ),

    // pancake tab
    MyTab(
      title: 'Last\nWeek',
      iconPath: 'assets/images/purchase.png',
    ),

    // pizza tab
    MyTab(
      title: 'Current\nMonth',
      iconPath: 'assets/images/bill_sales.png',
    ),
    // pizza tab
    MyTab(
      title: 'Last\nMonth',
      iconPath: 'assets/images/Fruits.png',
    ),
  ];

  int totalPurchaseBill = 0;

  Future<void> fetchTodayPurchaseBill() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var PurBillToday = data['today_Bill_count'];
      double PurBill = PurBillToday as double;
      totalPurchaseBill = PurBill.toInt();
    }
    if (mounted) {
      setState(() {
        totalPurchaseBill = totalPurchaseBill;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: Responsive.isDesktop(context)
            ? null
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
        body: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.grey[200], // Adjust color as needed
                  child: SideMenu(),
                ),
              ),
            Expanded(
              flex: 10,
              child: Column(
                children: [
                  Responsive.isDesktop(context)
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Purchase',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' Report',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20.0, bottom: 50.0),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Column(
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                  'Today Bills: $totalPurchaseBill'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 64, 113, 153),
                                        ), // Change the color here
                                        padding: MaterialStateProperty.all<
                                            EdgeInsets>(
                                          EdgeInsets.symmetric(
                                            vertical: 16,
                                            horizontal: 25,
                                          ), // Increase the padding here
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      : Padding(
                          padding:
                              const EdgeInsets.only(bottom: 30.0, left: 20),
                          child: Row(
                            children: [
                              Text(
                                'Purchase',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' Report',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.grey[600]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 61.0, bottom: 0.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                      builder: (context) =>
                                          TodayPurchaseBillPage(), // Replace with your page
                                    ));
                                  },
                                  child: Column(
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                              'Today Bills: $totalPurchaseBill'),
                                        ],
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Color.fromARGB(255, 64, 113, 153),
                                    ), // Change the color here
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.symmetric(
                                        vertical: 16,
                                        horizontal: 25,
                                      ), // Increase the padding here
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                  // tab bar
                  TabBar(tabs: myTabs),

                  // tab bar view
                  Expanded(
                    child: TabBarView(
                      children: [
                        // donut page
                        TodayPurchasePage(),

                        // burger page
                        // TodayPurchaseBillPage(),

                        // smoothie page
                        PurchaseCurrentWeekPage(),

                        // pancake page
                        PurchaseLastWeekPage(),

                        // pizza page
                        PurchaseCurrentMonthPage(),

                        PurchaseLastMonthPage(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
