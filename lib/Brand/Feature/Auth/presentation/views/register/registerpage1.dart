import 'package:cloozy/Brand/Core/common/gender_drop_down.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/register/registerpage2.dart';
import 'package:flutter/material.dart';

class RegisterPage1 extends StatefulWidget {
  final int roleId;

   RegisterPage1({Key? key, required this.roleId}) : super(key: key);

  @override
  _RegisterPage1State createState() => _RegisterPage1State();
}

class _RegisterPage1State extends State<RegisterPage1> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _selectedGender = 'female';

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegisterPage2(
            roleId: widget.roleId,
            name: _nameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            gender: _selectedGender,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text("Enter Personal Information",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) =>
                    !value!.contains('@') ? "Invalid Email" : null,
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone Number"),
                validator: (value) =>
                    value!.length < 10 ? "Invalid Phone Number" : null,
              ),
              GenderDropdown(
                  value: _selectedGender,
                  onChange: (value) => _selectedGender = value!),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _goToNextPage,
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
