import 'package:flutter/material.dart';
import 'package:SuperMarket/responsive.dart';
import 'package:SuperMarket/config/header.dart';
import '../../../constants.dart';
import 'Salesfile_info_card.dart';

class Dash_SalesMain extends StatelessWidget {
  const Dash_SalesMain({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    // return FutureBuilder(
    //   future: Future.wait([
    //     SalesCard.fetchTotalSalesBill(),
    //     SalesCard.fetchTotalSaleProduct(),
    //   ]), // Fetch both totalSalesBill and totalSaleProduct values
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text('datanot availabale');
    //     } else if (snapshot.hasError) {
    //       return Text('Error: ${snapshot.error}');
    //     } else {
    //       // Total sales bill and total sale product fetched successfully
    //       final List<int?> data = snapshot.data as List<int?>;
    //       final totalSalesBill = data[0] ?? 0;
    //       final totalSaleProduct = data[1] ?? 0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Responsive.isDesktop(context)
                    ? Text(
                        "Today Sales & Purchase",
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                    : Text(
                        "Today Sales",
                        style: Theme.of(context).textTheme.titleMedium,
                      )),
          ],
        ),
        SizedBox(height: defaultPadding),
        // FutureBuilder<List<SalesCard>>(
        //   future: SalesCard.fetchDataFromApi(
        //     totalSalesBill,
        //     totalSaleProduct,
        //   ), // Pass both totalSalesBill and totalSaleProduct values
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return CircularProgressIndicator();
        //     } else if (snapshot.hasError) {
        //       return Text('Error: ${snapshot.error}');
        //     } else if (!snapshot.hasData) {
        //       return Text('No data available.');
        //     } else {
        //       final demoMyFiles = snapshot.data!;
        //       return GridView.builder(
        //         physics: NeverScrollableScrollPhysics(),
        //         shrinkWrap: true,
        //         itemCount: demoMyFiles.length,
        //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: _size.width < 650 ? 2 : 4,
        //           crossAxisSpacing: defaultPadding,
        //           mainAxisSpacing: defaultPadding,
        //           childAspectRatio:
        //               _size.width < 650 && _size.width > 350 ? 1.3 : 1,
        //         ),
        //         itemBuilder: (context, index) =>
        //             FileInfoCard(info: demoMyFiles[index]),
        //       );
        //     }
        //   },
        // ),
        Responsive(
          mobile: Column(
            children: [
              FileInfoCard(),
              SizedBox(
                height: defaultPadding,
              ),
              Header5(),
              SizedBox(
                height: defaultPadding,
              ),
              FileInfoCard2(),
            ],
          ),
          desktop: Row(
            children: [
              FileInfoCard(),
              SizedBox(
                width: 6,
              ),
              FileInfoCard2(),
            ],
          ),
        ),
      ],
    );
  }
}
