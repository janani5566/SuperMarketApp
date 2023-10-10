import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:SuperMarket/Purchase/PurchaseBill.dart';
import 'package:SuperMarket/Purchase/PurchasePaymentdetail.dart';
import 'package:SuperMarket/Sales/SalesBillSubForm.dart';
import 'package:SuperMarket/Sales/SalesProductSubForm.dart';
import 'package:SuperMarket/screens/dashboard/components/Dash_SalesCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:SuperMarket/config/responsive.dart';
import '../../../constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FileInfoCard extends StatefulWidget {
  const FileInfoCard({
    Key? key,
  }) : super(key: key);

  @override
  State<FileInfoCard> createState() => _FileInfoCardState();
}

class _FileInfoCardState extends State<FileInfoCard> {
  @override
  void initState() {
    super.initState();
    fetchTotalAmount();
    fetchTodaySalesBill();
    fetchTotalSaleProduct();
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
    // Fetch the API URL from SharedPreferences or another source
    String? ipAddress = await SharedPrefs.getIpAddress();
    String apiUrl = 'http://$ipAddress/Sales/';

    // Make an HTTP GET request
    http.Response response = await http.get(Uri.parse(apiUrl));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the JSON response
      var data = json.decode(response.body);

      // Assuming the JSON response is an object
      if (data is Map<String, dynamic>) {
        var todayBillCount = data['today_Bill_count'];

        // Check if todayBillCount is an integer
        if (todayBillCount is int) {
          setState(() {
            totalSalesBill = todayBillCount;
          });
        }
      }
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

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SalesBill(), // Replace with your page
            ));
          },
          child: Container(
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.14 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.44,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Color.fromARGB(255, 64, 113, 153),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFFF4081).withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xFFFF4081).withOpacity(0.1),
                          )),
                      child: SvgPicture.asset(
                        "assets/icons/food-bag.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xFFFF4081) ?? Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  'Sales : ₹ $totalSalesAmount .0 ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                ProgressLine(
                  color: Color(0xFFFF4081),
                  percentage: 77,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bills : $totalSalesBill",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: Responsive.isDesktop(context) ? 6 : 12,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  SalesProductPage(), // Replace with your page
            ));
          },
          child: Container(
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.13 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.44,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Color.fromARGB(255, 64, 113, 153),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF00897B).withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xFF00897B).withOpacity(0.1),
                          )),
                      child: SvgPicture.asset(
                        "assets/icons/groceries.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xFF00897B) ?? Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  'Products',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                ProgressLine(
                  color: Color(0xFF00897B),
                  percentage: 60,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "$totalSaleProduct",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class FileInfoCard2 extends StatefulWidget {
  const FileInfoCard2({
    Key? key,
  }) : super(key: key);

  @override
  State<FileInfoCard2> createState() => _FileInfoCard2State();
}

class _FileInfoCard2State extends State<FileInfoCard2> {
  void initState() {
    super.initState();
    fetchTotalPurchase();
    fetchTodayPurchaseBill();
    fetchTotalPurchasePayment();
  }

  int totalPurchaseAmount = 0;

  Future<void> fetchTotalPurchase() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var PurFinalAmountToday = data['purchase_amount_today'];
      double Puramount = PurFinalAmountToday as double;
      totalPurchaseAmount = Puramount.toInt();
    }
    if (mounted) {
      setState(() {
        totalPurchaseAmount = totalPurchaseAmount;
      });
    }
  }

  int totalPurchaseBill = 0;

  Future<void> fetchTodayPurchaseBill() async {
    // Fetch the API URL from SharedPreferences or another source
    String? ipAddress = await SharedPrefs.getIpAddress();
    String apiUrl = 'http://$ipAddress/purchase/';

    // Make an HTTP GET request
    http.Response response = await http.get(Uri.parse(apiUrl));

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // Parse the JSON response
      var data = json.decode(response.body);

      // Assuming the JSON response is an object
      if (data is Map<String, dynamic>) {
        var todayBillCount = data['today_Bill_count'];

        // Check if todayBillCount is an integer
        if (todayBillCount is int) {
          setState(() {
            totalPurchaseBill = todayBillCount;
          });
        }
      }
    }
  }

  int totalPurchasePayment = 0;

  Future<void> fetchTotalPurchasePayment() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase-payment/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    // Assuming the JSON response is an object
    if (data is Map<String, dynamic>) {
      var PurPaymentToday = data['sum_PurchasePayment_Amount_today'];
      double PurPayment = PurPaymentToday as double;
      totalPurchasePayment = PurPayment.toInt();
    }
    if (mounted) {
      setState(() {
        totalPurchasePayment = totalPurchasePayment;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TodayPurchaseBillPage(), // Replace with your page
            ));
          },
          child: Container(
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.14 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.44,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Color.fromARGB(255, 64, 113, 153),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFFE040FB).withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xFFE040FB).withOpacity(0.1),
                          )),
                      child: SvgPicture.asset(
                        "assets/icons/shopping.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xFFE040FB) ?? Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  'Purchase:₹$totalPurchaseAmount.0 ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                ProgressLine(
                  color: Color(0xFFE040FB),
                  percentage: 23,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Bills : $totalPurchaseBill  ",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          width: Responsive.isDesktop(context) ? 6 : 12,
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  TodayPurchasePaymentPage(), // Replace with your page
            ));
          },
          child: Container(
            width: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.14 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.44,
            padding: EdgeInsets.all(defaultPadding),
            decoration: BoxDecoration(
              color: secondaryColor,
              border: Border.all(
                color: Color.fromARGB(255, 64, 113, 153),
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(defaultPadding * 0.75),
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                          color: Color(0xFF007EE5).withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Color(0xFF007EE5).withOpacity(0.1),
                          )),
                      child: SvgPicture.asset(
                        "assets/icons/Payment.svg",
                        colorFilter: ColorFilter.mode(
                            Color(0xFF007EE5) ?? Colors.black, BlendMode.srcIn),
                      ),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.black,
                      size: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Text(
                  'Payments',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                ProgressLine(
                  color: Color(0xFF007EE5),
                  percentage: 33,
                ),
                SizedBox(
                  height: defaultPadding,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "₹$totalPurchasePayment.0",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = primaryColor,
    required this.percentage,
  }) : super(key: key);

  final Color? color;
  final int? percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth * (percentage! / 100),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
