import 'package:cloozy/Brand/Feature/Dashboard/presentation/widgets/visitors_number_card.dart';

class VisiotoreNumsModel {
  int viewCount;
  int? todayViews;
  String percentage_change;
  VisiotoreNumsModel(
      {required this.viewCount,
      required this.percentage_change,
      this.todayViews});
  factory VisiotoreNumsModel.fromJson(Map<String, dynamic> json) {
    return VisiotoreNumsModel(
      viewCount: json['views_count'] ?? 0,
      percentage_change: json['percentage_change'] ?? "0% up from yesterday",
      todayViews: json['today_views'] ?? 0,
    );
  }
}
