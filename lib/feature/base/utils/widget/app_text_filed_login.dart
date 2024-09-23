import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';

class AppFloatTextField extends StatelessWidget {
  final String? hint;
  final String? inerHint;
  final String? errorText;
  final TextEditingController? controller;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? onValidate;
  final bool? isError;
  final VoidCallback? suffixOnTap;
  final VoidCallback? onTap;
  final ValueChanged<String>? onFiledSubmitted;
  final bool? isSuffix;
  final FocusNode? focusNode;
  final bool? isPrefix;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final bool obscureText;
  final VoidCallback? prefixOnTap;
  final double? height;
  final bool? currentState;
  final int? maxLine;

  const AppFloatTextField(
      {super.key,
        this.maxLine,
      this.hint,
      this.obscureText = false,
      this.errorText,
      this.controller,
      this.suffixIcon,
      this.onChange,
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
      this.onFiledSubmitted,
      this.inerHint,
      this.focusNode, this.currentState});

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: const BoxDecoration(color: AppColors.white),
      height: height ?? displayHeight(context) * 0.06,
      child: TextFormField(
        maxLines: maxLine,
        focusNode: focusNode,
        onFieldSubmitted: onFiledSubmitted,
        validator: onValidate,
        autofocus: true,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChange,
        controller: controller,
        cursorColor: Colors.blue,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        decoration:
        InputDecoration(

          isDense: false,
          // hintText: inerHint,
          hintStyle: const TextStyle(color: AppColors.textGray),
          floatingLabelStyle:currentState! ?
              AppStyles.subHeading.copyWith(color: AppColors.primery):AppStyles.subHeading,
          label: Text(
            '$inerHint',
            // style: const TextStyle(color: AppColors.textGray),
          ),
          prefixIcon: isPrefix!
              ? InkWell(
                  onTap: prefixOnTap,
                  child: Icon(prefixIcon, color: Colors.blue))
              : null,

          errorText: isError! ? errorText : null,
          suffixIcon: isSuffix!
              ? InkWell(
                  onTap: suffixOnTap,
                  child: Icon(suffixIcon, color: Colors.grey),
                )
              : null,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.gray, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          // filled: true,
          // fillColor: AppColors.gray,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(10)),),

          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isError! ? Colors.red : Colors.blue,
                width:2),
            borderRadius:const BorderRadius.all(Radius.circular(10))),
          // ),
          // focusedErrorBorder: isError!
          //     ? const OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10)),
          //     borderSide: BorderSide(color: Colors.red, width: 2))
          //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );

  }
}
