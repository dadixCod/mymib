import 'package:flutter/material.dart';

class RoundedTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscure;
  const RoundedTextField({
    super.key,
    required this.text,
    required this.controller,
    this.validator,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        labelText: text,
        hintText: text,
      ),
      validator: validator,
    );
  }
}
