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
    List<String> parts = percentageChange.split(' ');
    String percentageValue = parts.first;
    String remainingText = percentageChange
        .substring(percentageValue.length)
        .trim(); // "up to yesterday"

    double parsedValue = double.tryParse(percentageValue) ?? 0;

    Color percentageColor = parsedValue <= 0 ? Colors.red : Colors.green;
    String iconPath = parsedValue <= 0 ? downArrow : topArrow;
   
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Daily Sales",
            style: TextStyle(fontSize: 18, color: grayColor),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "$dailySales EGP",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                money,
                height: 40,
                width: 40,
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              SvgPicture.asset(iconPath),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: " $percentageValue ", // Percentage value
                      style: TextStyle(
                          fontSize: 17,
                          color: percentageColor,
                          fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: remainingText, // Remaining text
                      style: const TextStyle(fontSize: 17, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
