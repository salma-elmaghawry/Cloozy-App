import 'package:cloozy/Core/common/custom_TextFormField.dart.dart';
import 'package:cloozy/Core/common/gender_drop_down.dart';
import 'package:cloozy/Features/Auth/views/widgets/password_confirm_field.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _gender = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Register Page",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                //Name
                CustomTextformfield(
                  controller: _nameController,
                  label: "Name",
                  validator: (value) {
                    value!.isEmpty ? "Required" : null;
                  },
                ),
                //Email
                CustomTextformfield(
                    controller: _emailController,
                    label: "Email",
                    validator: (value) =>
                        value!.contains('@') ? null : "Invalid email"),
                //Phone
                CustomTextformfield(
                  controller: _phoneController,
                  label: "Phone",
                  KeyboardType: TextInputType.phone,
                  validator: (value) =>
                      value!.length < 10 ? "Invalid phone number" : null,
                ),
                //Password
                CustomTextformfield(
                  controller: _passwordController,
                  label: "Password",
                  obscureText: true,
                  validator: (value) => value!.length < 6 ? "Too short" : null,
                ),
                //confirm Password
                PasswordConfirmField(
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController),
                //gender
                GenderDropdown(
                    value: _gender, onChange: (value) => _gender = value!),
                SizedBox(height: 40),
                ElevatedButton(onPressed: () {
                  

                }, child: Text("Register"))
              ],
            )),
      ),
    );
  }
}
