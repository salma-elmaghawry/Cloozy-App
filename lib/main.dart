import 'package:cloozy/Features/Auth/manager/cubits/register/register_cubit.dart';
import 'package:cloozy/Features/Auth/manager/repository/auth_repository.dart';
import 'package:cloozy/Features/Auth/views/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => RegisterCubit(AuthRepository()),
        child: RegisterPage(),
      ),
    );
  }
}

