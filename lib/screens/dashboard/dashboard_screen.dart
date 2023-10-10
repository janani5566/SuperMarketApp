import 'package:SuperMarket/responsive.dart';
import 'package:SuperMarket/screens/dashboard/components/Dash_SalesCard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SuperMarket/config/header.dart';
import 'package:flutter/services.dart';
import '../../constants.dart';
import 'package:SuperMarket/screens/dashboard/components/header.dart';
import 'components/DashbWeekly_SalesCard.dart';
import 'components/monthlyDash_details.dart';
import 'package:upgrader/upgrader.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<bool?> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Confirm Exit",
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          content: Text(
            "Are you sure you want to exit?",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Text("Yes"),
              onPressed: () async {
                // Close the app
                SystemNavigator.pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 64, 113, 153),
              ),
              child: Text("No"),
              onPressed: () {
                // Close the dialog
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return UpgradeAlert(
      upgrader: Upgrader(),
      child: SafeArea(
        child: SingleChildScrollView(
          primary: false,
          padding: EdgeInsets.all(defaultPadding),
          child: WillPopScope(
            onWillPop: () async {
              // Call the exit confirmation dialog when the user wants to leave the page
              bool exitConfirmed =
                  await _showExitConfirmationDialog(context) ?? false;
              return exitConfirmed;
            },
            child: Column(
              children: [
                HeadWidget(),
                SizedBox(height: defaultPadding),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Dash_SalesMain(),
                          SizedBox(height: 10),
                          Header3(),
                          SizedBox(height: defaultPadding),
                          WeeklySalesCard(),
                          if (Responsive.isMobile(context))
                            SizedBox(height: defaultPadding),
                          if (Responsive.isMobile(context)) Monthly_dash(),
                        ],
                      ),
                    ),
                    if (!Responsive.isMobile(context))
                      SizedBox(width: defaultPadding),
                    // On Mobile means if the screen is less than 850 we don't want to show it
                    if (!Responsive.isMobile(context))
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 0.0),
                          child: Column(
                            children: [
                              Header4(),
                              SizedBox(height: defaultPadding),
                              Monthly_dash(),
                            ],
                          ),
                        ),
                      ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
