import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {super.key,
      this.controller,
      this.border = 24,
      this.hint,
      this.leading,
      this.widget,
      this.isPassword = false,
      this.type,
      this.validator,
      this.trailing});

  final String? hint;
  final double? border;
  final double? widget;
  final IconData? leading;
  final Widget? trailing;
  final bool? isPassword;
  final TextEditingController? controller;
  final TextInputType? type;
  final String Function(String? str)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget ?? 350,
        child: TextFormField(
          controller: controller,
          validator: validator ??
              (str) {
                if (str!.isEmpty) {
                  return "Invalid entry";
                }
                return null;
              },
          obscureText: isPassword!,
          keyboardType: type,
          decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(border!)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: hint,
            prefixIcon: Icon(leading),
            suffixIcon: trailing,
          ),
        ));
  }
}
