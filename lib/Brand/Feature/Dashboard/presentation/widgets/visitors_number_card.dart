import 'package:cloozy/Core/common/add_svgicon.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';

class VisitorsNumberCard extends StatelessWidget {
  const VisitorsNumberCard({super.key});

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
              Text("324",
                  style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              AddSvgicon(assetPath: people)
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              AddSvgicon(assetPath: topArrow),
              Text(
                " 3.2% ",
                style: TextStyle(fontSize: 17, color: greenColor),
              ),
              Text('Up from yesterday',
                  style: TextStyle(fontSize: 17, color: Colors.white70))
            ],
          ),
        ],
      ),
    );
  }
}
