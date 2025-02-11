import 'package:cloozy/Brand/Feature/Dashboard/presentation/Screens/dashboardPage.dart';
import 'package:cloozy/Brand/Feature/orders/presentation/screens/orders_page.dart';
import 'package:cloozy/Brand/Feature/payment/presentation/screens/payment_page.dart';
import 'package:cloozy/Brand/Feature/profile/presentation/screens/profile_page.dart';
import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/helper/assets.dart';
import 'package:cloozy/Core/helper/secure_storage.dart';
import 'package:cloozy/Intro/Auth/presentation/views/customer_or_brand.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// Other imports...

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  late List<Widget> _screens;
  String? _token;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _loadToken();
    _initializeScreens();
  }

  Future<void> _loadToken() async {
   try {
    final isValid = await SecureStorage.isValidToken();
    if (!isValid) {
      _redirectToLogin();
      return;
    }
    
    final token = await SecureStorage.getToken();
    if (token == null || token.isEmpty) {
      _redirectToLogin();
      return;
    }

    setState(() {
      _token = token;
      _loading = false;
    });
  } catch (e) {
    _redirectToLogin();
  }
  }

  void _redirectToLogin() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const CustomerOrBrand()),
        (route) => false,
      );
    });
  }

  void _initializeScreens() {
    _screens = [
      if (_token != null) Dashboardpage(token: _token!),
      if (_token != null) OrdersPage(token: _token!),
      if (_token != null) PaymentPage(token: _token!),
      if (_token != null) ProfilePage(token: _token!),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          buttonBackgroundColor: primaryColor,
          color: primaryColor,
          index: _selectedIndex,
          backgroundColor: Colors.transparent,
          animationDuration: const Duration(milliseconds: 300),
          items: [
            _buildNavItem(dashboard),
            _buildNavItem(order),
            _buildNavItem(payment),
            _buildNavItem(profile),
          ],
          onTap: (index) => setState(() => _selectedIndex = index),
        ),
      ),
    );
  }

  Widget _buildNavItem(String asset) => Padding(
    padding: const EdgeInsets.all(10.0),
    child: SvgPicture.asset(asset),
  );
}