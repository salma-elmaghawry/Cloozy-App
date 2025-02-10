class DailySalesModel {
  final double todaySales;
  final String percentageChange;
  DailySalesModel({required this.todaySales, required this.percentageChange});
  factory DailySalesModel.fromJson(Map<String, dynamic> json) {
    return DailySalesModel(
        todaySales: (json['today_sales']as num).toDouble(),
        percentageChange: json['percentage_change'] as String);
  }
}
