import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Core/common/custom_headline.dart';
import 'package:cloozy/Core/common/cutom_button.dart';
import 'package:cloozy/Core/common/gender_drop_down.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Core/common/next_botton.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Intro/Auth/presentation/views/login_page.dart';
import 'package:cloozy/Intro/Auth/presentation/views/register/registerpage2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                title: "Create a new account",
                color: grayColor,
                fontSize: 16,
              ),
              const SizedBox(height: 30),
              CustomHeadline(title: "Name"),
              const SizedBox(height: 10),
              CustomTextformfield(
                controller: _nameController,
                label: "Name",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    name,
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Please enter your name" : null,
              ),
              const SizedBox(height: 30),
              CustomHeadline(title: "Email"),
              const SizedBox(height: 10),
              CustomTextformfield(
                controller: _emailController,
                label: "Email",
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    email,
                  ),
                ),
                validator: (value) =>
                    !value!.contains('@') ? "Invalid Email" : null,
              ),
              const SizedBox(height: 30),
              CustomHeadline(title: "Phone"),
              const SizedBox(height: 10),
              CustomTextformfield(
                controller: _phoneController,
                label: "+20",
                keyboardType: TextInputType.number,
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    phone,
                  ),
                ),
                validator: (value) =>
                    value!.length < 10 ? "Invalid Phone Number" : null,
              ),
              const SizedBox(height: 30),
              //gender
              const Text("Gender",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildGenderOption("male", "Male", male),
                    const SizedBox(width: 70),
                    _buildGenderOption("female", "Female", female),
                  ],
                ),
              ),

              // GenderDropdown(
              //     value: _selectedGender,
              //     onChange: (value) => _selectedGender = value!),
              const SizedBox(height: 20),

              ButtonWithIcon(
                assetpath: shortArrow,
                text: "Next",
                onPressed: _goToNextPage,
              ),
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

  Widget _buildGenderOption(String value, String text, String iconPath) {
    bool isSelected = _selectedGender == value;
    Color selectedColor = value == "female" ? secondaryColor : primaryColor;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = value;
        });
      },
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? selectedColor : Colors.grey,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selectedColor,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(
            width: 10,
          ),
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected ? selectedColor : Colors.grey,
              BlendMode.srcIn,
            ),
          ), // Icon with dynamic color
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isSelected ? selectedColor : Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
