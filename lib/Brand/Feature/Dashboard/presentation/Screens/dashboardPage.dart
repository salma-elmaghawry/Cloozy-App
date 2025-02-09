import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/recent_orders.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/sales_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/sold_catergories_card.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/visitors_number_card.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloozy/Core/helper/assets.dart';

class Dashboardpage extends StatelessWidget {
  Dashboardpage({super.key});
  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bgColor,
        title: CustomHeadline(
          title: "Dashboard",
          fontSize: 24,
        ),
        actions: [
          IconButton(icon: Icon(Icons.settings, size: 28), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.notifications, size: 28), onPressed: () {}),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            CustomTextformfield(
              controller: search,
              label: "Search",
              prefixIcon: Padding(
                padding: EdgeInsets.all(10.0),
                child: SvgPicture.asset(
                  "assets/icons/search.svg",
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomHeadline(
              title: "Metrics",
              fontSize: 24,
            ),
            const SizedBox(
              height: 10,
            ),
            SalesCard(),
            const SizedBox(
              height: 10,
            ),
            const VisitorsNumberCard(),
            const SizedBox(
              height: 10,
            ),
            SoldCatergoriesCard(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomHeadline(title: "Recent Orders", fontSize: 26),
                TextButton(
                  onPressed: () {},
                  child: Text("See all >",
                      style: TextStyle(fontSize: 16, color: Colors.blue)),
                ),
              ],
            ),
            SizedBox(height: 15),
            RecentOrders(),
            SizedBox(height: 15),
            CustomHeadline(title: "Recent Payments", fontSize: 26),
          ],
        ),
      ),
    );
  }
}
