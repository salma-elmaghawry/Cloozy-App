import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  final String token;
  const PaymentPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  Center(child: Text("Payment")),
    );
  }
}
