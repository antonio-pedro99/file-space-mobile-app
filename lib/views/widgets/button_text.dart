import 'package:flutter/material.dart';
import 'package:space_client_app/views/theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      this.color = white,
      this.onTap,
      this.text,
      this.isOutlined = false,
      this.textColor = deepPurple,
      this.widget = 100})
      : super(key: key);

  final String? text;
  final Color? color;
  final Color? textColor;
  final VoidCallback? onTap;
  final double? widget;
  final bool? isOutlined;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: widget,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: isOutlined! ? Border.all(color: Colors.white) : null,
              color: isOutlined! ? Colors.transparent : color,
              borderRadius: BorderRadius.circular(16)),
          child: Center(
            child: Text(
              text!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: !isOutlined! ? textColor : Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
