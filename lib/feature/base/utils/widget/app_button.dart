import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.label,
    this.onTap,
    this.isFill = false,
    this.height,
    this.bgColor,
    this.borderColor,
    this.width,
    this.textStyle,
    this.isDisabled = false,
    this.isBorderColor =  false,
  });

  final String? label;
  final VoidCallback? onTap;
  final bool isFill;
  final bool isBorderColor;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final bool isDisabled;
  final Color? bgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
                // padding: isFill ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 10),
      // color: bgColor,
      height: height,
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: !isFill ? bgColor : null,
          side: isBorderColor ? BorderSide(color: borderColor ?? Colors.transparent) : null,
          padding: isFill ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: isBorderColor?)
          ),
        ),
        onPressed: isDisabled ? null : onTap,
        child: Text(
          label ?? '',
          style: isFill ? AppStyles.buttonLightTextStyle : textStyle,
        ),
      ),
    );
  }
}
