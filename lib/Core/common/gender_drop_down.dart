import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChange;
  const GenderDropdown(
      {super.key, required this.value, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      items: ['female','male'].
      map((gender)=>DropdownMenuItem(
        value: gender,
        child: Text(gender.toUpperCase()),
      )).toList(), 
      onChanged: onChange,
      decoration: InputDecoration(labelText: "Gender"),
      );
  }
}
