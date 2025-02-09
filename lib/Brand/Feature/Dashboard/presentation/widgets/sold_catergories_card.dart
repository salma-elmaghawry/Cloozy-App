import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/category_percentage.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SoldCatergoriesCard extends StatelessWidget {
  const SoldCatergoriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.all(16),
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
                Text("Sold Categories",
                    style: TextStyle(fontSize: 18, color: Colors.black54)),
                SizedBox(height: 10),
                CategoryPercentage(
                  color: primaryColor,
                  title: "Pants 58.6%",
                ),
                SizedBox(height: 5),
                CategoryPercentage(
                  color: Colors.blue,
                  title: "Shirts 18.7%",
                ),
                SizedBox(height: 5),
                CategoryPercentage(
                  color: greenColor,
                  title: "Hoodies 22.7%",
                ),
              ],
            ),
          ),
          SizedBox(
            width: 140,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 58.6,
                    color: Color(0xff003B5C),
                    radius: 30,
                  ),
                  PieChartSectionData(
                    value: 18.7,
                    color: Colors.blue,
                    radius: 30,
                  ),
                  PieChartSectionData(
                    value: 22.7,
                    color: Color.fromARGB(255, 25, 110, 96),
                    radius: 30,
                  ),
                ],
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

