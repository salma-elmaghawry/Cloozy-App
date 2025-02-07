import 'package:cloozy/Brand/Core/common/constant.dart';

import 'package:cloozy/Intro/Auth/data/cubits/login/login_cubit.dart';
import 'package:cloozy/Intro/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Intro/Auth/data/cubits/verify_email/verify_email_cubit.dart';
import 'package:cloozy/Intro/Auth/data/repository/auth_repository.dart';
import 'package:cloozy/Intro/Auth/presentation/customer_or_brand.dart';
import 'package:cloozy/Intro/Auth/presentation/views/forget%20password/new_password.dart';
import 'package:cloozy/Intro/Splash/presentation/views/splash_screen.dart';
import 'package:cloozy/Intro/onboarding/onboarding_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(AuthRepository()),
        ),
        BlocProvider(
          create: (context) => VerifyEmailCubit(AuthRepository()),
        )
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: bgColor,
        ),
        routes: {
          'onboarding': (context) => OnboardingScreen(),
          'Splash': (context) => SplashScreen(),
          'forget_password': (context) => NewPassword(),
          'customer_orbrand': (context) => CustomerOrBrand(),
        },
        initialRoute: 'customer_orbrand',
      ),
    );
  }
}
