import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisitorsNumberCard extends StatelessWidget {
  VisitorsNumberCard(
      {super.key, required this.percentage, required this.totoalVisitors});
  final int totoalVisitors;
  final String percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Visitors Number",
              style: TextStyle(fontSize: 18, color: Colors.white70)),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$totoalVisitors",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              SvgPicture.asset(topArrow),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              SvgPicture.asset(topArrow),
              Text(
                " $percentage",
                style: TextStyle(fontSize: 17, color: greenColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
