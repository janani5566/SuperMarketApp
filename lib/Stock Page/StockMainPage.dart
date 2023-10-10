import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:SuperMarket/screens/main/components/side_menu.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CatNameScreen(),
    );
  }
}

class CatNameScreen extends StatefulWidget {
  @override
  _CatNameScreenState createState() => _CatNameScreenState();
}

class _CatNameScreenState extends State<CatNameScreen> {
  List<String> itemTitles = [];
  List<int> categoryData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/toStockCatWise/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);
    List<String> titles = [];
    List<int> dataWithAmount = [];

    for (var item in data) {
      titles.add(item['cat']);
      dataWithAmount.add(item['total_qty'].toInt());
    }

    setState(() {
      itemTitles = titles;
      categoryData = dataWithAmount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                Padding(
                  padding: const EdgeInsets.only(
                    top: 38.0,
                    bottom: 25,
                  ),
                  child: Text(
                    'Total Stock Categories', // Title text
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        " * Tap to view details",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                itemTitles.isEmpty
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: Responsive.isDesktop(context)
                                  ? 6
                                  : 3, // Adjust the number of columns as needed
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                            ),
                            itemCount: itemTitles.length,
                            itemBuilder: (context, index) {
                              return CatListItem(
                                catName: itemTitles[index],
                                catCount: categoryData[index],
                              );
                            },
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CatListItem extends StatelessWidget {
  final String catName;
  final int catCount;

  CatListItem({required this.catName, required this.catCount});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the ProductTablePage and pass the category name
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductTablePage(catName: catName),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Color.fromARGB(255, 64, 113, 153),
              width: 2.0, // Set the border width
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Card(
            color: Color.fromARGB(255, 210, 230, 247),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 2),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 20,
                  child: Image.asset(
                    'assets/images/products.png',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  catName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Total Qty: $catCount',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTablePage extends StatefulWidget {
  final String catName;

  ProductTablePage({required this.catName});

  @override
  State<ProductTablePage> createState() => _ProductTablePageState();
}

class _ProductTablePageState extends State<ProductTablePage> {
  List<Map<String, dynamic>> tableData = [];

  @override
  void initState() {
    super.initState();
    fetchProductData(widget
        .catName); // Pass the catName to fetch data for the specific category
  }

  Future<void> fetchProductData(String catName) async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/CatWise/';

    http.Response response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<Map<String, dynamic>> toyItems = [];

      for (var item in data) {
        if (item['cat'] == catName) {
          String itemName = item['name'];
          String itemQty = item['qty'].toString();
          toyItems.add({
            'name': itemName,
            'qty': itemQty,
          });
        }
      }
      setState(() {
        tableData = toyItems;
      });
    }
  }

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Center(
          child: Column(
            children: [
              Text(
                'Details',
                style: GoogleFonts.crimsonText(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                'All Stocks Based On Purchase and Sales',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Color.fromARGB(255, 210, 230, 247),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        controller: controller,
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
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
                            "ProductName",
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
                      height: MediaQuery.of(context).size.height * 0.07,
                      // width: 228.0,
                      width: Responsive.isDesktop(context)
                          ? MediaQuery.of(context).size.width *
                              0.3 // Adjust this value as needed
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
                            "Qty(*)",
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
                var date = data['name'].toString();
                var dateno = data['qty'].toString();
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
                                  0.3 // Adjust this value as needed
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
                                  0.3 // Adjust this value as needed
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
                    ],
                  ),
                );
              }).toList(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
