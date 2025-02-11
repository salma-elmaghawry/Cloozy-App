class OrdersModel {
  final int id;
  final double totalPrice;
  final String status;
  final String createdAt;

  OrdersModel({
    required this.id,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) {
    print(json['total_price'].runtimeType);
    return OrdersModel(
      id: json['id'],
      totalPrice: json['total_price'] is String
          ? double.parse(json['total_price']) // If it's a String
          : (json['total_price'] as num).toDouble(),
      // If it's a num
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
}
