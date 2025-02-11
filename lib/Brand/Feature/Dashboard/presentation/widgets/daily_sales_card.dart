import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailySalesCard extends StatelessWidget {
  final double dailySales;
  final String percentageChange;
  DailySalesCard(
      {super.key, required this.dailySales, required this.percentageChange});
  @override
  Widget build(BuildContext context) {
    // String iconPath = percentageChange > 0
    //     ? topArrow // Use your actual path
    //     : downArrow; 

    // Color percentageColor = percentageChange > 0 ? greenColor: Colors.red;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Daily Sales",
            style: TextStyle(fontSize: 18, color: grayColor),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$dailySales",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SvgPicture.asset(topArrow),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SvgPicture.asset(topArrow),
              Text(
                " $percentageChange",
                style: TextStyle(fontSize: 17, color: Colors.green),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
