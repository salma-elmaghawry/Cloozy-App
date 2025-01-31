import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Feature/Auth/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> pages = [
    {
      'image': 'assets/images/onboarding1.png',
      'title': 'Support Local Brands',
      'subtitle':
          'Shop from your favorite local brands and\nexplore unique styles crafted just for you.',
    },
    {
      'image': 'assets/images/onboarding2.png',
      'title': 'Shop Smart, Stay Trendy',
      'subtitle':
          'Get personalized fashion recommendations\nand the best deals in your area.',
    },
    {
      'image': 'assets/images/onboarding3.png',
      'title': 'Discover New Trends',
      'subtitle':
          'Stay updated with the latest fashion trends\nand curated collections daily.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: pages.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) => _buildPage(index),
      ),
    );
  }

  Widget _buildPage(int index) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          // Image Container
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pages[index]['image']),
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Text Content
          Text(
            pages[index]['title'],
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: PrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            pages[index]['subtitle'],
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const Spacer(),

          // Page Indicator
          SmoothPageIndicator(
            controller: _controller,
            count: pages.length,
            effect: WormEffect(
              activeDotColor: PrimaryColor,
              dotColor: Colors.grey,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
          const SizedBox(height: 24),

          // Button Row
          Row(
            children: [
              // Skip Button
              TextButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => RegisterPage())),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: PrimaryColor,
                    fontSize: 16,
                  ),
                ),
              ),

              // Spacer
              const Spacer(),

              // Next/Get Started Button
              ElevatedButton(
                onPressed: () => _handleButtonPress(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text(
                  _currentPage == pages.length - 1 ? 'Get Started' : '>',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleButtonPress() {
    if (_currentPage == pages.length - 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => RegisterPage()));
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}
