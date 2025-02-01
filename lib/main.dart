import 'package:cloozy/Feature/Auth/manager/cubits/login/login_cubit.dart';
import 'package:cloozy/Feature/Auth/manager/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/manager/repository/auth_repository.dart';
import 'package:cloozy/Feature/Auth/views/login_page.dart';
import 'package:cloozy/Feature/Auth/views/register_page.dart';
import 'package:cloozy/Feature/home/home_page.dart';
import 'package:cloozy/Feature/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => OnboardingScreen(),
          '/register': (context) => RegisterPage(),
          '/home': (context) => HomePage(),
          '/login': (content) => LoginPage(),
        },
        initialRoute: '/login',
      ),
    );
  }
}
