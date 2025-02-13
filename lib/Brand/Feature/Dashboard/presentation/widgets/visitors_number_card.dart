import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class VisitorsNumberCard extends StatelessWidget {
  VisitorsNumberCard(
      {super.key, required this.percentage, required this.totoalVisitors,this.isRedacted = false});
  final int totoalVisitors;
  final String percentage;
  final bool isRedacted;

  @override
  Widget build(BuildContext context) {
    List<String> parts = percentage.split(' ');
    String percentageValue = parts.first;
    String remainingText = percentage
        .substring(percentageValue.length)
        .trim(); // "up to yesterday"

    double parsedValue = double.tryParse(percentageValue) ?? 0;

    Color percentageColor = parsedValue <= 0 ? Colors.red : Colors.green;
    String iconPath = parsedValue <= 0 ? downArrow : topArrow;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Visitors Number",
              style: TextStyle(fontSize: 18, color: Colors.white70)),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("$totoalVisitors",
                  style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                people,
                height: 40,
                width: 40,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              if (isRedacted)
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[200]!,
                  child: Container(
                    width: 24, // Adjust width to match your SVG size
                    height: 24, // Adjust height to match your SVG size
                    color: Colors.white, // Background color for shimmer
                  ),
                )
              else
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
