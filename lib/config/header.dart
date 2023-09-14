import 'package:flutter/material.dart';
import 'package:SuperMarket/config/responsive.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatefulWidget {
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Today Sales',
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class Header2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Today Purchase',
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class Header3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          "Weekly Sales",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class Header4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          "Monthly Sales",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class Header5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          "Today Purchase",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class Header6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Weekly Purchase',
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class Header7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Monthly Purchase ',
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class Header8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Weekly Sales',
          style: TextStyle(
            color: Colors.black,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}

class Header9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Text(
          'Month Expenses',
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width *
                    0.02 // Adjust this value as needed
                : MediaQuery.of(context).size.width * 0.04,
            fontFamily: 'Cambria',
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 5),
      ],
    );
  }
}
