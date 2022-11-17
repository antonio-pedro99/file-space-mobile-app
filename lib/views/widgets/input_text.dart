import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {
  const CustomTextInput(
      {Key? key,
      this.controller,
      this.border = 24,
      this.hint,
      this.leading,
      this.widget,
      this.trailing})
      : super(key: key);

  final String? hint;
  final double? border;
  final double? widget;
  final IconData? leading;
  final IconData? trailing;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: widget ?? 350,
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(border!)),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: hint,
            prefixIcon: Icon(leading),
          ),
        ));
  }
}
