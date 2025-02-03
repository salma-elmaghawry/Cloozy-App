import 'package:cloozy/Core/common/add_logo.dart';
import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/headline_text_style.dart';
import 'package:cloozy/Core/common/linewithtapword.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Feature/Auth/presentation/views/login_page.dart';
import 'package:cloozy/Feature/home/presentation/views/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/custom_snakbar.dart';
import 'package:cloozy/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/data/models/roles_model.dart';
import 'package:cloozy/Feature/Auth/presentation/views/register/registerpage2.dart';
import 'package:flutter_svg/svg.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  String _gender = 'female';
  int? _selectedRoleId;
  List<Role> _roles = [];

  @override
  void initState() {
    super.initState();
    _fetchRoles();
  }

  void _fetchRoles() {
    setState(() {
      _roles = [
        Role(id: 2, name: 'Brand'),
        Role(id: 3, name: 'Customer'),
      ];
      _selectedRoleId = _roles.first.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            showCustomSnackBar(context, state.message, true);
          }
          if (state is RegisterSuccess) {
            if (state.message == 'User registered successfully.') {
              showCustomSnackBar(context, state.message, false);
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              });
            } else {
              showCustomSnackBar(context, state.message, true);
            }
          }
        },
        child: registerPageBody(),
      ),
    );
  }

  Padding registerPageBody() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            addLogo(),
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Create a new account',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            const SizedBox(height: 20),

            /// Name
            CustomTextformfield(
              controller: _nameController,
              label: "Name",
              suffixIcon: const Icon(Icons.person),
              validator: (value) => value!.isEmpty ? "Required" : null,
            ),
            const SizedBox(height: 20),

            /// Email
            CustomTextformfield(
              controller: _emailController,
              label: "Email",
              suffixIcon: const Icon(Icons.email_outlined),
              validator: (value) =>
                  value!.contains('@') ? null : "Invalid email",
            ),
            const SizedBox(height: 20),

            /// Phone
            CustomTextformfield(
              controller: _phoneController,
              label: "Phone",
              suffixIcon: const Icon(Icons.phone),
              KeyboardType: TextInputType.phone,
              validator: (value) =>
                  value!.length < 10 ? "Invalid phone number" : null,
            ),
            const SizedBox(height: 20),

            /// Gender Selection with RadioListTile
            const SizedBox(height: 20),
            const Text("Gender",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),

            Row(
              children: [
                Radio<String>(
                  value: "male",
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                const Text("Male"),
                Radio<String>(
                  value: "female",
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                const Text("Female"),
              ],
            ),
            const SizedBox(height: 30),

            /// Role Selection with RadioListTile
            const SizedBox(height: 20),
            const Text(
              'Select Role:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Row(
              children: _roles.map((role) {
                return RadioListTile<int>(
                  title: Text(role.name),
                  value: role.id,
                  groupValue: _selectedRoleId,
                  onChanged: (value) {
                    setState(() {
                      _selectedRoleId = value!;
                    });
                  },
                );
              }).toList(),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: PrimaryColor,
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 15), // Optional: Add padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage2(
                        name: _nameController.text,
                        email: _emailController.text,
                        phone: _phoneController.text,
                        gender: _gender,
                        selectedRoleId: _selectedRoleId,
                      ),
                    ),
                  );
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Next ",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Icon(Icons.arrow_right_alt, color: Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20),
            LineWithAction(
                actionName: "Login",
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                title: "Already have an account? "),
          ],
        ),
      ),
    );
  }
}
