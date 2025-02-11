class TopSoldModel {
  final int id;
  final String name;
  final int totalSold;
  final double percentage;

  TopSoldModel({required this.id, required this.name, required this.totalSold, required this.percentage});

  factory TopSoldModel.fromJson(Map<String, dynamic> json) {
    return TopSoldModel(
      id: json['id'],
      name: json['name'],
      totalSold: json['total_sold'],
      percentage: double.tryParse(json['percentage']?.replaceAll('%', '')) ?? 0.0,
    );
  }
}
