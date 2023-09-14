import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:SuperMarket/Purchase/PurchaseMain.dart';
import 'package:SuperMarket/Sales/SalesMainPage.dart';
import 'package:SuperMarket/SmartReport/SmartMainPage.dart';
import 'package:SuperMarket/Stock Page/StockMainPage.dart';
import 'package:SuperMarket/controllers/MenuAppController.dart';
import 'package:SuperMarket/screens/main/main_screen.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/buyp_insta.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Navigator.of(context).pushReplacement(
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
              );
            },
          ),
          DrawerListTile(
            title: "Sales",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SalesPage()));
            },
          ),
          DrawerListTile(
            title: "Purchase",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => PurchasePage()));
            },
          ),
          DrawerListTile(
            title: "Stock",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CatNameScreen()));
            },
          ),
          DrawerListTile(
            title: "Smart AI Report",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SmartPage()));
            },
          ),
          DrawerListTile(
            title: "Expenses",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatefulWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  State<DrawerListTile> createState() => _DrawerListTileState();
}

class _DrawerListTileState extends State<DrawerListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Container(
        color: isHovered
            ? Color.fromARGB(255, 64, 113, 153)
            : Colors.transparent, // Change background color on hover

        child: ListTile(
          onTap: widget.press,
          horizontalTitleGap: 0.0,
          leading: SvgPicture.asset(
            widget.svgSrc,
            color: isHovered
                ? Colors.white
                : Colors.black, // Change color on hover
            // Change color on hover
            height: 16,
          ),
          title: Text(
            widget.title,
            style: TextStyle(
              color: isHovered
                  ? Colors.white
                  : Colors.black, // Change color on hover
            ),
          ),
        ),
      ),
    );
  }
}
