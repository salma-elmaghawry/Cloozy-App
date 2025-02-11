import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
    final String token;
  const ProfilePage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("profile")),
    );
  }
}
