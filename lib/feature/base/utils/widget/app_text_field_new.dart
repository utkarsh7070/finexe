import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../namespase/app_colors.dart';
import '../namespase/display_size.dart';


class AppTextFieldNew extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? onValidate;
  final bool? isError;
  final VoidCallback? suffixOnTap;
  final VoidCallback? onTap;
  final bool? isSuffix;
  final bool? isPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool obscureText;
  final VoidCallback? prefixOnTap;
  final double? height;
  final ValueChanged<String>? onFiledSubmitted;
  final int? maximumLines;

  const AppTextFieldNew({
    super.key,
    this.maximumLines,
    this.hint,
    this.obscureText = false,
    this.errorText,
    this.controller,
    this.suffixIcon,
    this.onFiledSubmitted,
    required this.onChange,
    this.isError = false,
    this.suffixOnTap,
    this.onTap,
    this.isSuffix = false,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.prefixIcon,
    this.prefixOnTap,
    this.onValidate,
    this.height,
    this.isPrefix = false,
  });

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        depth: -2, // Negative depth for an indented look
        intensity: 0.9,
        lightSource: LightSource.topLeft,oppositeShadowLightSource: false,shadowLightColorEmboss: AppColors.white ,
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
      ),
      child: Container(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.attendanceBgColor,
            borderRadius: BorderRadius.circular(12),
            border: isError!
                ? Border.all(color: Colors.red, width: 2) // Error border
                : null, // No border initially
          ),
          child: TextFormField(
            maxLines: maximumLines,
            validator: onValidate,
            obscureText: obscureText,
            onTap: onTap,
            onChanged: onChange,
            controller: controller,
            cursorColor: Colors.blue,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            onFieldSubmitted: onFiledSubmitted,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.grayColor3),
              errorText: isError! ? errorText : null,
              prefixIcon: isPrefix!
                  ? InkWell(
                onTap: prefixOnTap,
                child: Icon(prefixIcon, color: Colors.blue),
              )
                  : null,
              suffixIcon: isSuffix!
                  ? InkWell(
                onTap: suffixOnTap,
                child: Icon(suffixIcon, color: Colors.blue),
              )
                  : null,
              border: InputBorder.none, // No visible border
            ),
          ),
        ),
      ),
    );
  }

}


/*class AppTextFieldNew extends StatelessWidget {
  final String? hint;
  final String? errorText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? onValidate;
  final bool? isError;
  final VoidCallback? suffixOnTap;
  final VoidCallback? onTap;
  final bool? isSuffix;
  final bool? isPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool obscureText;
  final VoidCallback? prefixOnTap;
  final double? height;
  final ValueChanged<String>? onFiledSubmitted;
  final int? maximumLines;

  const AppTextFieldNew(
      {super.key,
      this.maximumLines,
      this.hint,
      this.obscureText = false,
      this.errorText,
      this.controller,
      this.suffixIcon,
      this.onFiledSubmitted,
      required this.onChange,
      this.isError = false,
      this.suffixOnTap,
      this.onTap,
      this.isSuffix = false,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.prefixIcon,
      this.prefixOnTap,
      this.onValidate,
      this.height,
      this.isPrefix = false});

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
        shape: NeumorphicShape.concave,
        depth: -2, // Negative depth for an indented look
        intensity: 0.9,
        lightSource: LightSource.topLeft,
        color: AppColors.attendanceBgColor, // Background color
        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),

      ),
      child: Container(
        // decoration: const BoxDecoration(color: AppColors.white),
        height: height ?? displayHeight(context) * 0.07,
        alignment: Alignment.center,
        child: Center(
          child: TextFormField(

            maxLines: maximumLines,
            validator: onValidate,
            // autofocus: true,
            obscureText: obscureText,
            onTap: onTap,
            onChanged: onChange,
            controller: controller,
            cursorColor: Colors.blue,
            textInputAction: textInputAction,
            keyboardType: textInputType,
            onFieldSubmitted: onFiledSubmitted,

            decoration: InputDecoration(
              isDense: true,
                *//*enabledBorder: const OutlineInputBorder(

                    borderSide: BorderSide(color: AppColors.subgraytext)),*//*
              //  floatingLabelBehavior: FloatingLabelBehavior.always,
                labelStyle: TextStyle(color: isError! ? Colors.red : null),
                prefixIcon: isPrefix!
                    ? InkWell(
                        onTap: prefixOnTap,
                        child: Icon(prefixIcon, color: Colors.blue))
                    : null,
                labelText: hint,
                // hintText: hint,
                errorText: isError! ? errorText : null,
                suffixIcon: isSuffix!
                    ? InkWell(
                        onTap: suffixOnTap,
                        child: Icon(suffixIcon, color: Colors.blue),
                      )
                    : null,
                filled: true,
                fillColor: AppColors.attendanceBgColor,
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  // borderSide: BorderSide(
                  //   // style: BorderStyle.none,
                  //   color: AppColors.secondaryButtonColor,
                  // ),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: const BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(
                      color: isError! ? Colors.red : Colors.blue,
                      width: isError! ? 2 : 1),
                ),
                focusedErrorBorder: isError!
                    ? const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(color: Colors.red, width: 2))
                    : null),
          ),
        ),
      ),
    );
  }
}*/
