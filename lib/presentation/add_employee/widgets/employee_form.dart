import 'package:flutter/material.dart';

class EmployeeForm extends StatelessWidget {
  const EmployeeForm({
    super.key,
    required this.controller,
    this.labelText,
    this.onTap,
  });

  final TextEditingController controller;
  final String? labelText;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onTap: onTap,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText cannot be empty';
        }
        return null;
      },
    );
  }
}
