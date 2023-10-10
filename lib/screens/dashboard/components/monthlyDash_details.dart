import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:SuperMarket/IpAddress/database_helper.dart';
import '../../../constants.dart';
import 'chart.dart';
import 'monthly_info_card.dart';

class Monthly_dash extends StatefulWidget {
  const Monthly_dash({
    Key? key,
  }) : super(key: key);

  @override
  State<Monthly_dash> createState() => _Monthly_dashState();
}

class _Monthly_dashState extends State<Monthly_dash> {
  @override
  void initState() {
    super.initState();
    fetchTotalAmountThisMonth();
    fetchTotalAmountLastMonth();
    fetchTotalAmountThisMonthPurchase();
    fetchTotalAmountLastMonthPurchase();
  }

  int totalAmountSalesCurrentMonth = 0;

  Future<void> fetchTotalAmountThisMonth() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var salesFinalAmountToday = data['sales_finalamount_current_month'];
      double amount = salesFinalAmountToday as double;
      totalAmountSalesCurrentMonth = amount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountSalesCurrentMonth = totalAmountSalesCurrentMonth;
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
      var LastMonth = data['sales_finalamount_last_month'];
      double Lastamount = LastMonth as double;
      totalAmountLastMonth = Lastamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountLastMonth = totalAmountLastMonth;
      });
    }
  }

  int totalAmountThisMonthP = 0;

  Future<void> fetchTotalAmountThisMonthPurchase() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var thisMonth = data['purchase_amount_current_month'];
      double Monthamount = thisMonth as double;
      totalAmountThisMonthP = Monthamount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountThisMonthP = totalAmountThisMonthP;
      });
    }
  }

  int totalAmountLastMonthP = 0;

  Future<void> fetchTotalAmountLastMonthPurchase() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var lastMonth = data['purchase_amount_last_month'];
      double Month1amount = lastMonth as double;
      totalAmountLastMonthP = Month1amount.toInt();
    }
    if (mounted) {
      setState(() {
        totalAmountLastMonthP = totalAmountLastMonthP;
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Chart(),
          monthlyInfoCard(
            svgSrc: "assets/images/payment.png",
            title: "Current Month Sales",
            amountOfFiles: "1.3GB",
            numOfFiles: totalAmountSalesCurrentMonth,
          ),
          monthlyInfoCard(
            svgSrc: "assets/images/products.png",
            title: "Last Month Sales",
            amountOfFiles: "15.3GB",
            numOfFiles: totalAmountLastMonth,
          ),
          monthlyInfoCard(
            svgSrc: "assets/images/purchase.png",
            title: "Current Month Purchase",
            amountOfFiles: "1.3GB",
            numOfFiles: totalAmountThisMonthP,
          ),
          monthlyInfoCard(
            svgSrc: "assets/images/Fruits.png",
            title: "Last Month Purchase",
            amountOfFiles: "1.3GB",
            numOfFiles: totalAmountLastMonthP,
          ),
        ],
      ),
    );
  }
}
