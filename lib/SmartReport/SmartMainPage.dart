import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:SuperMarket/SmartReport/FastMovingDetail.dart';
import 'package:SuperMarket/SmartReport/SlowMovingDetailPage.dart';
import 'package:SuperMarket/controllers/MenuAppController.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:SuperMarket/screens/main/components/side_menu.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SmartPage extends StatefulWidget {
  const SmartPage({Key? key}) : super(key: key);

  @override
  State<SmartPage> createState() => _SmartPageState();
}

class _SmartPageState extends State<SmartPage> {
  @override
  Widget build(BuildContext context) {
    // define a list of options for the dropdown
    final List<String> FastMove = ["CurrentWeek", "CurrentMonth", "LastMonth"];
    final List<String> SlowMove = ["CurrentWeek", "CurrentMonth", "LastMonth"];

    void _navigateToPage(String FastMove) {
      // Navigate to a different page based on the selected value
      if (FastMove == "CurrentWeek") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              FastMovingCurrentWeek(), // Replace with your page
        ));
      } else if (FastMove == "CurrentMonth") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              FastMovingCurrentMonth(), // Replace with your page
        ));
      } else if (FastMove == "LastMonth") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FastMovingPreMonth(), // Replace with your page
        ));
      }
    }

    void _navigateToPage2(String SlowMove) {
      // Navigate to a different page based on the selected value
      if (SlowMove == "CurrentWeek") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SlowMovingCurrentWeek(), // Replace with your page
        ));
      } else if (SlowMove == "CurrentMonth") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              SlowMovingCurrentMonth(), // Replace with your page
        ));
      } else if (SlowMove == "LastMonth") {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SlowMovingPreMonth(), // Replace with your page
        ));
      }
    }

    // the selected value
    String? _selectedAnimal;
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ), // Back icon
                        onPressed: () {
                          Navigator.of(context).pop(); // Navigate back
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    'Smart Report',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
                SizedBox(height: 30), // Add spacing
                // Add a container with text and DropdownButton above it
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 64, 113, 153),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 300.0,
                  height: 150.0,
                  child: Column(
                    children: [
                      SizedBox(height: 20), // Add spacing

                      Text(
                        'Top Selling Products',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 18), // Add spacing
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 113, 153),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          value: _selectedAnimal,
                          onChanged: (value) {
                            _navigateToPage(value!);
                          },
                          hint: const Center(
                              child: Text(
                            'Choose',
                            style: TextStyle(color: Colors.white),
                          )),
                          // Hide the default underline
                          underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Colors.amber,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.yellow,
                          ),
                          isExpanded: true,

                          // The list of options
                          items: FastMove.map((e) => DropdownMenuItem(
                                value: e,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black, // Change this color
                                    ),
                                  ),
                                ),
                              )).toList(),

                          // Customize the selected item
                          selectedItemBuilder: (BuildContext context) =>
                              FastMove.map((e) => Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.amber,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30), // Add spacing
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Color.fromARGB(255, 64, 113, 153),
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 300.0,
                  height: 150.0,
                  child: Column(
                    children: [
                      SizedBox(height: 20), // Add spacing

                      Text(
                        'Slow Moving Products',
                        style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(height: 18), // Add spacing
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        width: 150,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 64, 113, 153),
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<String>(
                          value: _selectedAnimal,
                          onChanged: (value) {
                            _navigateToPage2(value!);
                          },
                          hint: const Center(
                              child: Text(
                            'Choose',
                            style: TextStyle(color: Colors.white),
                          )),
                          // Hide the default underline
                          underline: Container(),
                          // set the color of the dropdown menu
                          dropdownColor: Colors.amber,
                          icon: const Icon(
                            Icons.arrow_downward,
                            color: Colors.yellow,
                          ),
                          isExpanded: true,

                          // The list of options
                          items: SlowMove.map((e) => DropdownMenuItem(
                                value: e,
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    e,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black, // Change this color
                                    ),
                                  ),
                                ),
                              )).toList(),

                          // Customize the selected item
                          selectedItemBuilder: (BuildContext context) =>
                              FastMove.map((e) => Center(
                                    child: Text(
                                      e,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.amber,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
