import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  RecentOrders({super.key});

  final List<Map<String, dynamic>> orders = [
    {
      "id": "#12345",
      "cost": "\$25.99",
      "date": "2024-02-09",
      "status": "Completed",
      "color": Colors.green, // Ensure this is a Color object
    },
    {
      "id": "#12346",
      "cost": "\$19.99",
      "date": "2024-02-08",
      "status": "Pending",
      "color": Colors.orange,
    },
    {
      "id": "#12347",
      "cost": "\$49.99",
      "date": "2024-02-07",
      "status": "Cancelled",
      "color": Colors.red,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [
          // Table Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Order ID",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Cost",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Date",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
                Text("Status",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
          ),

          // Order List
          ...orders.map(
            (order) => Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order["id"],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text(order["cost"], style: TextStyle(fontSize: 16)),
                  Text(order["date"], style: TextStyle(fontSize: 16)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: order["color"].withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      order["status"],
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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
