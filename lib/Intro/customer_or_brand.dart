import 'package:cloozy/Brand/Core/common/add_logo.dart';
import 'package:cloozy/Brand/Core/common/constant.dart';
import 'package:cloozy/Brand/Core/common/custom_TextFormField.dart';
import 'package:cloozy/Brand/Core/common/cutom_button.dart';
import 'package:cloozy/Brand/Core/common/headline_text_style.dart';
import 'package:cloozy/Brand/Core/common/linewithtapword.dart';
import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/login_page.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/register/registerpage1.dart';
import 'package:cloozy/Brand/Feature/Auth/presentation/views/widgets/role_card.dart';
import 'package:flutter/material.dart';

class CustomerOrBrand extends StatefulWidget {
  const CustomerOrBrand({super.key});

  @override
  State<CustomerOrBrand> createState() => _CustomerOrBrandState();
}

class _CustomerOrBrandState extends State<CustomerOrBrand> {
  void _navigateToNextPage(BuildContext context, int id) {
    // Pass the selected id (2 for Brand or 3 for Customer) to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterPage1(roleId: id),
      ),
    );
  }

  bool isCustomerSelected = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 30),
            const AddLogo(),
            const SizedBox(height: 40),
            customText(
              title: "Sign Up As",
              color: Colors.black,
              fontSize: 24,
            ),
            customText(
              title: "Choose your role to continue",
              color: grayColor,
              fontSize: 16,
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoleCard(
                    isSelected: isCustomerSelected,
                    onTap: () {
                      setState(() {
                        isCustomerSelected = true;
                      });
                    },
                    title: "Customer",
                    imagePath: cutomerImg),
                const SizedBox(width: 20),
                RoleCard(
                    isSelected: !isCustomerSelected,
                    onTap: () {
                      setState(() {
                        isCustomerSelected = false;
                      });
                    },
                    title: "Brand",
                    imagePath: brandImg),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            CustomButton(
                text: "Next",
                onPressed: () => _navigateToNextPage(
                      context,
                      isCustomerSelected ? 3 : 2,
                    )),
            const SizedBox(height: 10),
            LineWithAction(
                actionName: "Login",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginPage(
                        roleId: isCustomerSelected ? 3 : 2,
                      ),
                    ),
                  );
                },
                title: "Already have an account? "),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
