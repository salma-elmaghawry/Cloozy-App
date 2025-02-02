import 'package:cloozy/Core/common/constant.dart';
import 'package:cloozy/Feature/Auth/data/cubits/register/register_cubit.dart';
import 'package:cloozy/Feature/Auth/presentation/views/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class skipTextButton extends StatelessWidget {
  const skipTextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
      child: const Text(
        "Skip",
        style: TextStyle(
          fontSize: 16,
          color: grayColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
