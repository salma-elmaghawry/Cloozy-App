import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/dashboardPage.dart';
import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/test.dart';
import 'package:cloozy/Brand/Feature/orders/presentation/screens/orders_page.dart';
import 'package:cloozy/Brand/Feature/payment/presentation/screens/payment_page.dart';
import 'package:cloozy/Brand/Feature/profile/presentation/screens/profile_page.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBar extends StatefulWidget {
  final String token;
  const BottomNavBar({super.key, required this.token});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Dashboardpage(),
    OrdersPage(),
    PaymentPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context)
            .copyWith(iconTheme: IconThemeData(color: Colors.white)),
        child: CurvedNavigationBar(
          buttonBackgroundColor: primaryColor,
          color: primaryColor,
          index: _selectedIndex,
          backgroundColor: Colors.transparent,
          animationDuration: Duration(milliseconds: 300), // Add duration
          items: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                dashboard,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                order,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                payment,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(
                profile,
              ),
            ),
          ],
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
