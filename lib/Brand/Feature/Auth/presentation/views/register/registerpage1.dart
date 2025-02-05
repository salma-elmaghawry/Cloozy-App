import 'package:cloozy/Brand/Core/common/add_logo.dart';
import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:cloozy/Brand/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/gender_drop_down.dart';
import 'package:cloozy/Brand/Core/common/headline_text_style.dart';
import 'package:cloozy/Brand/Core/common/linewithtapword.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/login_page.dart';
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
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 30),
              const AddLogo(),
              const SizedBox(height: 30),
              customText(
                title: "Sign Up",
                color: Colors.black,
                fontSize: 24,
              ),
              customText(
                title: "Enter Personal Information",
                color: grayColor,
                fontSize: 16,
              ),
              const SizedBox(height: 30),
              CustomTextformfield(
                controller: _nameController,
                label: "Name",
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 30),
              CustomTextformfield(
                controller: _emailController,
                label: "Email",
                validator: (value) =>
                    !value!.contains('@') ? "Invalid Email" : null,
              ),
              const SizedBox(height: 30),
              CustomTextformfield(
                controller: _phoneController,
                label: "Phone Number",
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.length < 10 ? "Invalid Phone Number" : null,
              ),
              const SizedBox(height: 30),
              GenderDropdown(
                  value: _selectedGender,
                  onChange: (value) => _selectedGender = value!),
              const SizedBox(height: 20),
              CustomButton(text: "Next", onPressed: _goToNextPage),
              const SizedBox(height: 10),
              LineWithAction(
                  actionName: "Login",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          roleId: widget.roleId,
                        ),
                      ),
                    );
                  },
                  title: "Already have an account? "),
            ],
          ),
        ),
      ),
    );
  }
}
