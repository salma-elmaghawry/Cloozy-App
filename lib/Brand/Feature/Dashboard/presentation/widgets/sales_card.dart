import 'package:cloozy/Core/common/add_svgicon.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';

class SalesCard extends StatelessWidget {
  const SalesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Average Daily Sales",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "5,600 EGP",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              AddSvgicon(assetPath: dollar),
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              AddSvgicon(assetPath: topArrow),
              Text(
                " 5.4% ",
                style: TextStyle(fontSize: 17, color:greenColor),
              ),
              Text('Up from yesterday',
                  style: TextStyle(fontSize: 17, color: Colors.grey))
            ],
          ),
        ],
      ),
    );
  }
}
