import 'package:cloozy/Brand/Feature/orders/data/models/orders_model.dart';
import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  RecentOrders({
    super.key,
    required this.ordersList,
  });

  final List<OrdersModel> ordersList;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: const Row(
              children: [
                Text("ID",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  width: 30,
                ),
                Text("Cost",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  width: 55,
                ),
                Text("Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                SizedBox(
                  width: 80,
                ),
                Text("Status",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
          ),

          // Order List
          ...ordersList.map(
            (order) => Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.id.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("${order.totalPrice.toString()} EGP",
                      style: const TextStyle(
                        fontSize: 14,
                      )),
                  Text(order.createdAt, style: const TextStyle(fontSize: 14)),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: getStatusColor(order.status)
                          .withOpacity(0.3), // Assuming statusColor is a field
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      order.status,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Color getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.orange;
    case 'processing':
      return Colors.blue;
    case 'shipped':
      return Colors.purple;
    case 'delivered':
      return Colors.green;
    case 'canceled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
