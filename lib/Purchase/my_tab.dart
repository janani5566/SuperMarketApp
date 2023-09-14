import 'package:flutter/material.dart';
import 'package:SuperMarket/config/responsive.dart';

class MyTab extends StatelessWidget {
  final String iconPath;
  final String title;

  const MyTab({
    required this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Tab(
        height: Responsive.isDesktop(context) ? 150 : 105,
        child: Column(
          children: [
            Container(
              height: Responsive.isDesktop(context) ? 100 : 50,
              width: Responsive.isDesktop(context) ? 100 : 800,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color.fromARGB(255, 64, 113, 153),
                ),
                shape: BoxShape.circle, // Make it a circle
              ),
              child: Image.asset(
                iconPath,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
