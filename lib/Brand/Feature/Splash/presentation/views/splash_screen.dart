import 'package:cloozy/Brand/Core/helper/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart'; // Import Get for navigation

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animations = List.generate(6, (index) {
      return Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeInOut),
        ),
      );
    });
//route to onboarding
    _controller.forward().then((_) {
      Get.offNamed('onboarding');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedCharacter(animation: _animations[0], svgPath: c),
                AnimatedCharacter(animation: _animations[1], svgPath: l),
                AnimatedCharacter(animation: _animations[2], svgPath: o1),
                AnimatedCharacter(animation: _animations[3], svgPath: o2),
                AnimatedCharacter(animation: _animations[4], svgPath: z),
                AnimatedCharacter(animation: _animations[5], svgPath: y),
              ],
            ),
            ScaleTransition(
              scale: _animations[5],
              child: SvgPicture.asset(
                arrow,
                height: 21,
                width: 180,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedCharacter extends AnimatedWidget {
  final String svgPath;

  AnimatedCharacter(
      {required Animation<double> animation, required this.svgPath})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Transform.translate(
      offset: Offset(0, -50 * animation.value),
      child: SvgPicture.asset(svgPath, height: 50),
    );
  }
}
