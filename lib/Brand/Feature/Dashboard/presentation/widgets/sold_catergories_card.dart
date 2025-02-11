import 'package:cloozy/Brand/Feature/Dashboard/data/models/top_sold_model.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/category_percentage.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SoldCatergoriesCard extends StatelessWidget {
  SoldCatergoriesCard(
      {super.key,
      required this.percentage,
      required this.name,
      required this.topSold});
  final String percentage;
  final String name;
  final List<TopSoldModel> topSold;
  final List<Color> colorPalette = [
    primaryColor,
    blueCOlor,
    balckgreen,
    pinkCOlor
  ];
  @override
  Widget build(BuildContext context) {
    double remainingPercentage =
        100 - topSold.fold(0, (sum, item) => sum + item.percentage);
    String formattedRemainingPercentage =
        remainingPercentage.toStringAsFixed(2);
    if (topSold.isEmpty) {
      return Container(
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: grayColor,
          borderRadius: BorderRadius.circular(10),
        ),
      ); // Or a message like "No data available"
    }

    return Container(
      height: 180,
      width: double.infinity,
      padding:const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Text("Sold Categories",
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
                const SizedBox(height: 10),
                ...topSold.map((category) {
                  int colorIndex =
                      topSold.indexOf(category) % colorPalette.length;
                  return CategoryPercentage(
                    color: colorPalette[colorIndex],
                    title: "${category.name} ${category.percentage}%",
                  );
                }).toList(),
                CategoryPercentage(
                  color: pinkCOlor,
                  title: "Others $formattedRemainingPercentage%",
                ),
              ],
            ),
          ),
          SizedBox(
            width: 140,
            child: PieChart(
              PieChartData(
                sections: topSold.map((category) {
                  int colorIndex =
                      topSold.indexOf(category) % colorPalette.length;
                  return PieChartSectionData(
                    showTitle: false,
                    value: category.percentage,
                    color: colorPalette[colorIndex],
                    radius: 30,
                  );
                }).toList()
                  ..add(PieChartSectionData(
                    showTitle: false,
                    value: remainingPercentage..toStringAsFixed(2),
                    color: pinkCOlor,
                    radius: 30,
                  )),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
