import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Core/common/skip_text_button.dart';
import 'package:cloozy/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/presentation/views/login_page.dart';
import 'package:cloozy/Feature/onboarding/custom_clippers.dart';
import 'package:cloozy/Feature/onboarding/onboardingpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int currentPage = 0;

  final List<OnboardingData> onboardingPages = [
    OnboardingData(
      image: 'assets/images/onboarding1.png',
      title: "Support Local Brands",
      description:
          "Shop from your favorite local brands and explore unique styles crafted just for you.",
      clipper: AsymmetricalCurveClipper(),
    ),
    OnboardingData(
      image: 'assets/images/onboarding2.png',
      title: "Curated Collections for You",
      description:
          "Get personalized fashion recommendations based on your style and preferences.",
      clipper: WaveCurveClipper(),
    ),
    OnboardingData(
      image: 'assets/images/onboarding3.png',
      title: "Shop Smart, Stay Trendy",
      description:
          "Exclusive deals, new arrivals, and the best\n of local fashion—all in one place!",
      clipper: SymmetricalCurveClipper(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemCount: onboardingPages.length,
            itemBuilder: (context, index) {
              return OnboardingPage(
                title: onboardingPages[index].title,
                description: onboardingPages[index].description,
                imageUrl: onboardingPages[index].image,
                clipper: onboardingPages[index].clipper,
              );
            },
          ),
          customIndicators(),
          Positioned(
            bottom: 40,
            left: 24,
            right: 24,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentPage != 2) skipTextButton(),
                Spacer(),
                if (currentPage < onboardingPages.length - 1)
                  IconButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/Short Arrow.svg",
                      color: Colors.white,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: PrimaryColor,
                      shape: CircleBorder(),
                      iconSize: 80,
                      padding: const EdgeInsets.all(12),
                    ),
                  )
                else
                  routetologin(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Positioned customIndicators() {
    return Positioned(
      bottom: 120,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          onboardingPages.length,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 8,
            width: currentPage == index ? 29 : 8,
            decoration: BoxDecoration(
              color: currentPage == index ? PrimaryColor : grayColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton routetologin(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: BlocProvider.of<RegisterCubit>(context),
              child: LoginPage(),
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: PrimaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 32,
          vertical: 12,
        ),
      ),
      child: const Text(
        "Get Started",
        style: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
