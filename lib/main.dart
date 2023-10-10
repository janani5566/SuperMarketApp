import 'package:SuperMarket/constants.dart';
import 'package:SuperMarket/controllers/MenuAppController.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:SuperMarket/IpAddress/IpScreen.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:SuperMarket/IpAddress/database_helper.dart';
import 'package:upgrader/upgrader.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SupermarketApp',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        canvasColor: secondaryColor,
      ),
      home: Container(
          color: const Color.fromRGBO(255, 255, 255, 1),
          child: UpgradeAlert(
              // upgrader: Upgrader(
              //   durationUntilAlertAgain: const Duration(seconds: 5),
              //   shouldPopScope: () => true,
              //   onIgnore: () {
              //     SystemNavigator.pop();
              //     throw UnsupportedError('_');
              //   },
              // ),
              child: SplashScreen())),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchData1();
  }

  String shopNames = '';
  Future<void> fetchData1() async {
    String? ipAddress = await SharedPrefs.getIpAddress();

    String apiUrl = 'http://$ipAddress/ShopName/';
    http.Response response = await http.get(Uri.parse(apiUrl));
    var data = json.decode(response.body);

    if (mounted) {
      setState(() {
        List<dynamic> shopNameList = data['Shop_names'];
        shopNames = shopNameList.join(', ');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    checkIpAndNavigate(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                // Color.fromARGB(255, 129, 207, 109),
                Colors.blue,
                Color.fromARGB(255, 102, 175, 235),
                //Color.fromARGB(237, 252, 107, 175),
              ]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/grocery.png",
                  height: 300.0,
                  width: 300.0,
                ),
                Text(
                  shopNames,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ],
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkIpAndNavigate(BuildContext context) async {
    String? ipAddress = await SharedPrefs.getIpAddress();
    if (ipAddress != null) {
      Timer(
          Duration(seconds: 3),
          () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                        create: (context) => MenuAppController(),
                      ),
                    ],
                    child: MainScreen(),
                  ),
                ),
              ));
    } else {
      Timer(
          Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => IpScreen())));
    }
  }
}
