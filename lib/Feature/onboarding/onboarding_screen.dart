import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Feature/Auth/views/register_page.dart';
import 'package:cloozy/Feature/onboarding/onboardingpage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                children: const [
                  OnboardingPage(
                    title: 'Support Local Brands',
                    description:
                        'Shop from your favorite local brands and explore unique styles crafted just for you.',
                    imageUrl: 'assets/images/onboarding1.png',
                  ),
                  OnboardingPage(
                    title: 'Curated Collections for You',
                    description:
                        ' Get personalized fashion recommendations based on your style and preferences.',
                    imageUrl: 'assets/images/onboarding2.png',
                  ),
                  OnboardingPage(
                    title: ' Shop Smart, Stay Trendy',
                    description:
                        'Exclusive deals, new arrivals, and the best of local fashion—all in one place!',
                    imageUrl: 'assets/images/onboarding3.png',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CustomIndicator(isActive: _currentIndex == index),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      _controller.jumpToPage(2);
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(fontSize: 14, color: grayColor),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (_currentIndex < 2) {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      } else {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      }
                    },
                    child: Text(_currentIndex == 2 ? "Get Started" : "Next",),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomIndicator extends StatelessWidget {
  final bool isActive;

  const CustomIndicator({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 30 : 10,
      decoration: BoxDecoration(
        color: isActive ? PrimaryColor : grayColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
