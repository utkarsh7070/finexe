import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hint;
  final String? inerHint;
  final double? width;
  final String? errorText;
  final bool isReadOnly;
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
  final int? length;
  final String? initialValue;

  const CustomTextFormField(
      {super.key,
      this.maxLine,
      this.width,
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
      this.isReadOnly = false,
      this.textInputAction = TextInputAction.done,
      this.textInputType,
      // this.initialValue,
      this.prefixIcon,
      this.prefixOnTap,
      this.onValidate,
      this.height,
      this.isPrefix = false,
      this.onFiledSubmitted,
      this.inerHint,
      this.focusNode,
      this.currentState = false,
      this.length,
      this.initialValue,
      });

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      maxLength: length,
      readOnly: isReadOnly,
      initialValue: initialValue,
      maxLines: maxLine,
      focusNode: focusNode,
      onFieldSubmitted: onFiledSubmitted,
      validator: onValidate,
      obscureText: obscureText,
      onTap: onTap,
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.blue,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      style: AppStyles.headingTextStyle,

      textAlignVertical: TextAlignVertical.top, // Add this property
      decoration: InputDecoration(
        isDense: false,
         hintText: hint,
        hintStyle: const TextStyle(color: AppColors.textGray),
        floatingLabelStyle: currentState!
            ? AppStyles.subHeading.copyWith(color: AppColors.primary)
            : AppStyles.subHeading,
        label: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('$inerHint',
              style:
                  // const TextStyle(fontSize: 14, color: AppColors.buttonBorderGray),
                  AppStyles.subHeading),
        ),
        prefixIcon: isPrefix!
            ? InkWell(
                onTap: prefixOnTap, child: Icon(prefixIcon, color: Colors.blue))
            : null,

        errorText: isError! ? errorText : null,
        suffixIcon: isSuffix!
            ? InkWell(
                onTap: suffixOnTap,
                child: Icon(suffixIcon, color: Colors.grey),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12.0, horizontal: 10.0), // Add this property
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.gray, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        // filled: true,
        // fillColor: AppColors.gray,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.gray, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),

        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: isError! ? Colors.red : Colors.blue, width: 2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        // ),
        // focusedErrorBorder: isError!
        //     ? const OutlineInputBorder(
        //     borderRadius: BorderRadius.all(Radius.circular(10)),
        //     borderSide: BorderSide(color: Colors.red, width: 2))
        //     : null       borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}
