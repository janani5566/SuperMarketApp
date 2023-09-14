import 'package:SuperMarket/config/responsive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:scrollable/exports.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:SuperMarket/IpAddress/database_helper.dart';

class TodayPurchaseBillPage extends StatefulWidget {
  @override
  _TodayPurchaseBillPageState createState() => _TodayPurchaseBillPageState();
}

class _TodayPurchaseBillPageState extends State<TodayPurchaseBillPage> {
  List<Map<String, dynamic>> tableData = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/purchase/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var jsonData = json.decode(response.body);

    if (jsonData['Purchase&Bill_TodayDetail'] != null) {
      var lastWeekSalesDetails = jsonData['Purchase&Bill_TodayDetail'] as List;
      tableData = List<Map<String, dynamic>>.from(lastWeekSalesDetails);
    }

    if (mounted) {
      setState(() {
        totalAmount = tableData.isNotEmpty
            ? double.parse(tableData.first['amount'].toString())
            : 0.0;
      });
    }
  }

  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Details (Purchase Bill)',
          style: GoogleFonts.crimsonText(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 210, 230, 247),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back, color: Colors.black)),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        height: 40,
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width *
                                0.25 // Adjust this value as needed
                            : MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 64, 113, 153),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "BillNo",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 40,
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width *
                                0.25 // Adjust this value as needed
                            : MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 64, 113, 153),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Qty",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Container(
                        height: 40,
                        width: Responsive.isDesktop(context)
                            ? MediaQuery.of(context).size.width *
                                0.25 // Adjust this value as needed
                            : MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 64, 113, 153),
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: Text(
                              "Amount",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (tableData.isNotEmpty)
                ...tableData.map((data) {
                  var date = data['serialno'].toString();
                  var dateno = data['itemscount'].toString();
                  var amount = data['amount'].toString();
                  bool isEvenRow = tableData.indexOf(data) % 2 == 0;
                  Color? rowColor = isEvenRow
                      ? Color.fromARGB(224, 255, 255, 255)
                      : Color.fromARGB(255, 174, 204, 228);

                  return Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            height: 40,
                            width: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width *
                                    0.25 // Adjust this value as needed
                                : MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: rowColor,
                              border: Border.all(
                                color: Color.fromARGB(221, 54, 54, 54),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                date,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.crimsonText(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            width: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width *
                                    0.25 // Adjust this value as needed
                                : MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: rowColor,
                              border: Border.all(
                                color: Color.fromARGB(221, 54, 54, 54),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                dateno,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.crimsonText(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            height: 40,
                            width: Responsive.isDesktop(context)
                                ? MediaQuery.of(context).size.width *
                                    0.25 // Adjust this value as needed
                                : MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: rowColor,
                              border: Border.all(
                                color: Color.fromARGB(221, 54, 54, 54),
                              ),
                            ),
                            child: Center(
                              child: Text(
                                amount,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.crimsonText(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}