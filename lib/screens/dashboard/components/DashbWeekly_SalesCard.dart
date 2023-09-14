import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:SuperMarket/models/weeklySalesModel.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';

class WeeklySalesCard extends StatefulWidget {
  const WeeklySalesCard({
    Key? key,
  }) : super(key: key);

  @override
  State<WeeklySalesCard> createState() => _WeeklySalesCardState();
}

class _WeeklySalesCardState extends State<WeeklySalesCard> {
  List<Map<String, dynamic>> tableData = [];

  double totalAmountCurrentWeek = 0.0;
  List<String> defaultDayNames = [
    "Sun ",
    "Mon",
    "Tue",
    "Wed ",
    "Thu",
    "Fri ",
    "Sat ",
  ];

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var jsonData = json.decode(response.body);

    if (jsonData['current_week_sales_details'] != null) {
      var lastWeekSalesDetails = jsonData['current_week_sales_details'] as List;
      tableData = List<Map<String, dynamic>>.from(lastWeekSalesDetails);
    }

    if (mounted) {
      setState(() {
        totalAmountCurrentWeek = tableData.isNotEmpty
            ? double.parse(tableData.first['finalamount_sum'].toString())
            : 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: Responsive.isDesktop(context)
              ? MediaQuery.of(context).size.width *
                  0.280 // Adjust this value as needed
              : MediaQuery.of(context).size.width * 0.44,
          padding: EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Current Week",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Center(
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Day",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      defaultDayNames.length,
                      (index) {
                        final dayName = defaultDayNames[index];
                        final dayData = tableData.firstWhere(
                          (data) =>
                              data['dt__date'] == getFormattedDate(dayName),
                          orElse: () => {'finalamount_sum': 0.0},
                        );
                        final finalAmount =
                            dayData['finalamount_sum']?.toDouble() ?? 0.0;
                        return TopSellingDataRow(
                          {'finalamount_sum': finalAmount},
                          dayName,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        WeeklySalesCard2(),
      ],
    );
  }

  String getFormattedDate(String dayName) {
    final now = DateTime.now();
    final currentWeekday = now
        .weekday; // Get the current day of the week (1-7, where 1 is Monday and 7 is Sunday)
    final daysToAdd = defaultDayNames.indexOf(dayName) - currentWeekday;
    final formattedDate = now.add(Duration(days: daysToAdd)).toString();
    return formattedDate.substring(0, 10); // Extract the YYYY-MM-DD part
  }
}

DataRow TopSellingDataRow(Map<String, dynamic> rowData, String defaultDayName) {
  double finalAmount = rowData['finalamount_sum']?.toDouble() ?? 0.0;

  return DataRow(
    cells: [
      DataCell(
        Container(
          child: Text(
            defaultDayName,
            style:
                TextStyle(color: Colors.white), // Display day name or default
          ),
        ),
      ),
      DataCell(
        Container(
          child: Text(
            finalAmount != ''
                ? finalAmount.toStringAsFixed(2)
                : "0.0", // Display "0.0" if finalAmount is 0 or missing
            style:
                TextStyle(color: Colors.white), // Display day name or default
            // Display total amount
          ),
        ),
      ),
    ],
  );
}

class WeeklySalesCard2 extends StatefulWidget {
  const WeeklySalesCard2({Key? key}) : super(key: key);

  @override
  State<WeeklySalesCard2> createState() => _WeeklySalesCard2State();
}

class _WeeklySalesCard2State extends State<WeeklySalesCard2> {
  List<Map<String, dynamic>> tableData1 = [];

  double totalAmountCurrentWeek = 0.0;
  List<String> defaultDayNames = [
    "Sun ",
    "Mon",
    "Tue",
    "Wed ",
    "Thu",
    "Fri ",
    "Sat ",
  ];

  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/Sales/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var jsonData = json.decode(response.body);

    if (jsonData['last_week_sales_details'] != null) {
      var lastWeekSalesDetails = jsonData['last_week_sales_details'] as List;
      tableData1 = List<Map<String, dynamic>>.from(lastWeekSalesDetails);
    }

    if (mounted) {
      setState(() {
        totalAmountCurrentWeek = tableData1.isNotEmpty
            ? double.parse(tableData1.first['finalamount_sum'].toString())
            : 0.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        width: Responsive.isDesktop(context)
            ? MediaQuery.of(context).size.width *
                0.278 // Adjust this value as needed
            : MediaQuery.of(context).size.width * 0.44,
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Last Week",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Center(
                child: DataTable(
                  columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(
                      label: Text(
                        "Day",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Amount",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                  rows: List.generate(
                    tableData1.length, // Use the actual data length
                    (index) => TopSellingDataRow2(
                      tableData1[index],
                      defaultDayNames[index %
                          defaultDayNames
                              .length], // Get default day names in a cycle
                      // Pass the data to the data row
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedDate(String dayName) {
    final now = DateTime.now();
    final currentWeekday = now
        .weekday; // Get the current day of the week (1-7, where 1 is Monday and 7 is Sunday)
    final daysToAdd = defaultDayNames.indexOf(dayName) - currentWeekday;
    final formattedDate = now.add(Duration(days: daysToAdd)).toString();
    return formattedDate.substring(0, 10); // Extract the YYYY-MM-DD part
  }
}

DataRow TopSellingDataRow2(
    Map<String, dynamic> rowData1, String defaultDayName) {
  return DataRow(
    cells: [
      DataCell(
        Container(
          child: Text(
            defaultDayName,
            style:
                TextStyle(color: Colors.white), // Display day name or default
          ),
        ),
      ),
      DataCell(
        Container(
          child: Text(
            rowData1['finalamount_sum']?.toStringAsFixed(2) ?? "",
            style:
                TextStyle(color: Colors.white), // Display day name or default
            // Display total amount
          ),
        ),
      ),
    ],
  );
}
