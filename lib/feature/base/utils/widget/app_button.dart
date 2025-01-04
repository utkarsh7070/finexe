import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    this.label,
    this.onTap,
    this.isFill = false,
    this.height,
    this.bgColor,
    this.borderColor,
    this.width,
    this.textStyle,
    this.isDisabled = false,
  }) : super(key: key);

  final String? label;
  final VoidCallback? onTap;
  final bool isFill;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final bool isDisabled;
  final Color? bgColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
                // padding: isFill ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 10),

      // color: bgColor,
      height: height,
      width: width,
      child: ElevatedButton(


        style: ElevatedButton.styleFrom(

          backgroundColor: !isFill ? bgColor : null,
          side: isFill ? BorderSide(color: borderColor ?? Colors.transparent) : null,
          padding: isFill ? EdgeInsets.zero : const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            
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
