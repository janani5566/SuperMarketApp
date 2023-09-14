import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:SuperMarket/Sales/CurrrentMonthSalesSubForm.dart';
import 'package:SuperMarket/Sales/LastMonthSalesSubForm.dart';
import 'package:SuperMarket/Sales/LastWeekSalesSubForm.dart';
import 'package:SuperMarket/Sales/SalesBillSubForm.dart';
import 'package:SuperMarket/Sales/SalesProductSubForm.dart';
import 'package:SuperMarket/Sales/SalesSubForm.dart';
import 'package:SuperMarket/Sales/currentWeekSalesSubForm.dart';
import 'package:SuperMarket/controllers/MenuAppController.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:SuperMarket/screens/main/components/side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
    fetchTodaySalesBill();
    fetchTotalSaleProduct();
    fetchTotalAmountThisWeek();
  }

  int totalSalesAmount = 0;

  Future<void> fetchTotalAmount() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var salesFinalAmountToday = data['sales_finalamount_today'];
      double amount = salesFinalAmountToday as double;
      totalSalesAmount = amount.toInt();
    }

    if (mounted) {
      // Check if the widget is still mounted before calling setState
      setState(() {
        totalSalesAmount = totalSalesAmount;
      });
    }
  }

  int totalSalesBill = 0;

  Future<void> fetchTodaySalesBill() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var salesBill = data['today_Bill_count'];
      double bill = salesBill as double;
      totalSalesBill = bill.toInt();
    }
    if (mounted) {
      setState(() {
        totalSalesBill = totalSalesBill;
      });
    }
  }

  int totalSaleProduct = 0;

  Future<void> fetchTotalSaleProduct() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/TodaySales-product/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var SaleProduct = data['sum_sales_products_today'];
      double total = SaleProduct as double;
      totalSaleProduct = total.toInt();
    }
    if (mounted) {
      setState(() {
        totalSaleProduct = totalSaleProduct;
      });
    }
  }

  int totalAmountSalesCurrentWeek = 0;

  Future<void> fetchTotalAmountThisWeek() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var salesFinalAmountToday = data['sales_finalamount_current_week'];
      double amount = salesFinalAmountToday as double;
      totalAmountSalesCurrentWeek = amount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountSalesCurrentWeek = totalAmountSalesCurrentWeek;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Responsive.isDesktop(context)
          ? null
          : AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
      body: Center(
        child: Row(
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 113, 153),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          alignment: Alignment.bottomCenter,
                          margin: Responsive.isDesktop(context)
                              ? EdgeInsets.only(
                                  top: 30,
                                  left: 90.0,
                                  right: 90.0,
                                  bottom: 15.0)
                              : EdgeInsets.only(
                                  left: 30.0, right: 30.0, bottom: 15.0),
                          padding: const EdgeInsets.all(30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Sales Report',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Today Sales",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) =>
                                            SalesSubForm(), // Replace with your page
                                      ));
                                    },
                                    child: Column(
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              '₹ $totalSalesAmount.0',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .copyWith(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                        Colors.white,
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
                                ],
                              ),
                              Image.asset(
                                'assets/images/grocery.png', // Replace with your image asset path
                                width: 100, // Adjust the width as needed
                                height: 200, // Adjust the height as needed
                                fit: BoxFit
                                    .cover, // You can change the fit as needed
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Responsive.isDesktop(context)
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 252.0, top: 15.0),
                                child: Container(
                                  height: 40,
                                  width: 600.0,
                                  alignment: Alignment.bottomCenter,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color:
                                            Color.fromARGB(255, 64, 113, 153),
                                      ),
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 7.0),
                                    child: Text(
                                      "Total Sales Information!!!",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .copyWith(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w900),
                                    ),
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 50.0,
                                    ),
                                    child: Container(
                                      height: 40,
                                      width: 300.0,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Color.fromARGB(
                                                255, 64, 113, 153),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 7.0),
                                        child: Text(
                                          "Total Sales Information!!!",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: Responsive.isDesktop(context)
                              ? EdgeInsets.only(top: 38.0, left: 0.0)
                              : EdgeInsets.only(top: 28.0, left: 0.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SalesBill(), // Replace with your page
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 64, 113, 153),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 120.0,
                                  width: Responsive.isDesktop(context)
                                      ? 300.0
                                      : 110.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Center children vertically
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Center children horizontally
                                    children: [
                                      Icon(Icons.receipt,
                                          size:
                                              40.0, // Adjust the size of the icon as needed
                                          color: Color.fromARGB(
                                              255, 64, 113, 153)),
                                      SizedBox(
                                          height:
                                              8.0), // Add spacing between icon and text
                                      Text(
                                        'Today Bills',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '$totalSalesBill',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: Responsive.isDesktop(context)
                              ? EdgeInsets.only(top: 38.0, left: 15.0)
                              : EdgeInsets.only(top: 28.0, left: 10.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SalesProductPage(), // Replace with your page
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 64, 113, 153),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 120.0,
                                  width: Responsive.isDesktop(context)
                                      ? 300.0
                                      : 110.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Center children vertically
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Center children horizontally
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/groceries.svg",
                                        colorFilter: ColorFilter.mode(
                                          Color.fromARGB(255, 64, 113, 153),
                                          BlendMode.srcIn,
                                        ),
                                        width:
                                            40.0, // Set the width to your desired value
                                        height:
                                            40.0, // Set the height to your desired value
                                      ),

                                      SizedBox(
                                          height:
                                              8.0), // Add spacing between icon and text
                                      Text(
                                        'Today Products',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '$totalSaleProduct',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: Responsive.isDesktop(context)
                              ? EdgeInsets.only(top: 38.0, left: 15.0)
                              : EdgeInsets.only(top: 28.0, left: 10.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        SalesCurrentWeekPage(), // Replace with your page
                                  ));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: Color.fromARGB(255, 64, 113, 153),
                                    ),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  height: 120.0,
                                  width: Responsive.isDesktop(context)
                                      ? 300.0
                                      : 110.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment
                                        .center, // Center children vertically
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Center children horizontally
                                    children: [
                                      SvgPicture.asset(
                                        "assets/icons/food-bag.svg",
                                        colorFilter: ColorFilter.mode(
                                          Color.fromARGB(255, 64, 113, 153),
                                          BlendMode.srcIn,
                                        ),
                                        width:
                                            40.0, // Set the width to your desired value
                                        height:
                                            40.0, // Set the height to your desired value
                                      ),

                                      SizedBox(
                                          height:
                                              8.0), // Add spacing between icon and text
                                      Text(
                                        'Current Week',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      SizedBox(height: 8.0),
                                      Text(
                                        '₹ $totalAmountSalesCurrentWeek .0',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall!
                                            .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w900),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    ContainerWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerWidget extends StatefulWidget {
  const ContainerWidget({Key? key}) : super(key: key);

  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  @override
  void initState() {
    super.initState();
    fetchTotalAmountThisMonth();
    fetchTotalAmountLastMonth();
    fetchTotalAmountLastWeek();
  }

  int totalAmountLastWeek = 0;

  Future<void> fetchTotalAmountLastWeek() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var LastWeek = data['sales_finalamount_previous_week'];
      double Lastamount = LastWeek as double;
      totalAmountLastWeek = Lastamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountLastWeek = totalAmountLastWeek;
      });
    }
  }

  int totalAmountThisMonth = 0;

  Future<void> fetchTotalAmountThisMonth() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var thisMonth = data['sales_finalamount_current_month'];
      double Monthamount = thisMonth as double;
      totalAmountThisMonth = Monthamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountThisMonth = totalAmountThisMonth;
      });
    }
  }

  int totalAmountLastMonth = 0;

  Future<void> fetchTotalAmountLastMonth() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var lastMonth = data['sales_finalamount_last_month'];
      double Month1amount = lastMonth as double;
      totalAmountLastMonth = Month1amount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountLastMonth = totalAmountLastMonth;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: Responsive.isDesktop(context)
              ? EdgeInsets.only(top: 38.0, left: 0.0)
              : EdgeInsets.only(top: 18.0, left: 0.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SalesPreviousWeekPage(), // Replace with your page
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 64, 113, 153),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 120.0,
                  width: Responsive.isDesktop(context) ? 300.0 : 110.0,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center children vertically
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center children horizontally
                    children: [
                      SvgPicture.asset(
                        "assets/icons/shopping.svg",
                        colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 64, 113, 153),
                          BlendMode.srcIn,
                        ),
                        width: 40.0, // Set the width to your desired value
                        height: 40.0, // Set the height to your desired value
                      ),
                      SizedBox(
                          height: 8.0), // Add spacing between icon and text
                      Text(
                        'Last Week',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '₹ $totalAmountLastWeek .0',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SalesCurrentMonthPage(), // Replace with your page
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 64, 113, 153),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 120.0,
                  width: Responsive.isDesktop(context) ? 300.0 : 110.0,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center children vertically
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center children horizontally
                    children: [
                      SvgPicture.asset(
                        "assets/icons/my-orders.svg",
                        colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 64, 113, 153),
                          BlendMode.srcIn,
                        ),
                        width: 40.0, // Set the width to your desired value
                        height: 40.0, // Set the height to your desired value
                      ),

                      SizedBox(
                          height: 8.0), // Add spacing between icon and text
                      Text(
                        'Current Month',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '₹ $totalAmountThisMonth .0',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 10.0),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SalesLastMonthPage(), // Replace with your page
                  ));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 64, 113, 153),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 120.0,
                  width: Responsive.isDesktop(context) ? 300.0 : 110.0,
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center children vertically
                    crossAxisAlignment: CrossAxisAlignment
                        .center, // Center children horizontally
                    children: [
                      SvgPicture.asset(
                        "assets/icons/fruit-basket.svg",
                        colorFilter: ColorFilter.mode(
                          Color.fromARGB(255, 64, 113, 153),
                          BlendMode.srcIn,
                        ),
                        width: 35.0, // Set the width to your desired value
                        height: 40.0, // Set the height to your desired value
                      ),

                      SizedBox(
                          height: 8.0), // Add spacing between icon and text
                      Text(
                        'Last Month',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '₹ $totalAmountLastMonth .0',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
