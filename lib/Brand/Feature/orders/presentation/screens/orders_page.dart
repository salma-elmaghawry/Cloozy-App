import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final String token;
  const OrdersPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('OrdersPage')),
    );
  }
}
