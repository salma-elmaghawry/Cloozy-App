import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.success,
    animType: AnimType.bottomSlide,
    title: 'Success',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}

void showErrorDialog(BuildContext context, String message) {
  AwesomeDialog(
    context: context,
    dialogType: DialogType.error,
    animType: AnimType.bottomSlide,
    title: 'Error',
    desc: message,
    btnOkOnPress: () {},
  ).show();
}