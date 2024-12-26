import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
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

  const AppTextField(
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
        this.height, this.isPrefix = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(color: AppColors.white),
      height: height ?? 60,
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
              floatingLabelBehavior:FloatingLabelBehavior.always,
              labelStyle:  TextStyle(color: isError!? Colors.red:null ),
              prefixIcon: isPrefix! ?InkWell(
                  onTap: prefixOnTap,
                  child: Icon(prefixIcon, color: Colors.blue)):null,
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
              fillColor: Colors.white12,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.all(Radius.circular(10)),
                // borderSide: BorderSide(
                //   // style: BorderStyle.none,
                //   color: AppColors.secondaryButtonColor,
                // ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
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
    );
  }
}
