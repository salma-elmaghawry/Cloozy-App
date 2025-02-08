import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final String value;
  final Function(String?) onChange;

  const GenderDropdown({
    super.key,
    required this.value,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
      print('[GenderDropdown] Current value: $value');
    print('[GenderDropdown] Available items: female, male');
    return DropdownButtonFormField<String>(
      value: value,
      items: const [
        DropdownMenuItem(
          value: 'female', // Must be lowercase
          child: Text('Female'),
        ),
        DropdownMenuItem(
          value: 'male', // Must be lowercase
          child: Text('Male'),
        ),
      ],
      onChanged: onChange,
      decoration: const InputDecoration(labelText: 'Gender'),
    );
  }
}
