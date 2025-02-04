
import 'package:cloozy/Brand/Feature/Auth/presentation/views/register/registerpage2.dart';
import 'package:flutter/material.dart';

class RegisterPage1 extends StatelessWidget {
  const RegisterPage1({Key? key}) : super(key: key);

  void _navigateToNextPage(BuildContext context, int id) {
    // Pass the selected id (2 for Brand or 3 for Customer) to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage2(roleId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Select Role", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToNextPage(context, 2), // 2 for Brand
              child: const Text("Brand"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _navigateToNextPage(context, 3), // 3 for Customer
              child: const Text("Customer"),
            ),
          ],
        ),
      ),
    );
  }
}
