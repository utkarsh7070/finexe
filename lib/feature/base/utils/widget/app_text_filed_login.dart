import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';

class AppFloatTextField extends StatelessWidget {
  final String? hint;
  final TextCapitalization textCapitalize;
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
  final VoidCallback? onEditingComplete;
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
final bool? isInitialValue;
  final String? initialValue;

  const AppFloatTextField(
      {super.key,
      this.textCapitalize = TextCapitalization.none,
      this.maxLine,
      this.width,
      this.hint,
      this.obscureText = false,
      this.errorText,
      this.controller,
      this.suffixIcon,
      this.onChange,
      this.isError = false,
      this.isInitialValue = false,
      this.suffixOnTap,
      this.onTap,
      this.onEditingComplete,
      this.isSuffix = false,
      this.isReadOnly = false,
      this.textInputAction = TextInputAction.done,
      this.textInputType = TextInputType.text,
      this.initialValue,
      this.prefixIcon,
      this.prefixOnTap,
      this.onValidate,
      this.height,
      this.isPrefix = false,
      this.onFiledSubmitted,
      this.inerHint,
      this.focusNode,
      this.currentState = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? displayWidth(context),
      height: height ?? displayHeight(context) * 0.06,
      // alignment: Alignment.center,
      child: TextFormField(
        onEditingComplete: onEditingComplete,
        textCapitalization: textCapitalize,
        readOnly: isReadOnly,
        initialValue: initialValue,
        maxLines: maxLine,
        focusNode: focusNode,
        onFieldSubmitted: onFiledSubmitted,
        validator: onValidate,
        // autofocus: true,
        obscureText: obscureText,
        onTap: onTap,
        onChanged: onChange,
        controller: controller,
        cursorColor: Colors.blue,
        textInputAction: textInputAction,
        keyboardType: textInputType,
        style: const TextStyle(fontSize: 12),
        // textAlignVertical: TextAlignVertical.center,
        // Add this property
        decoration: InputDecoration(
          isDense: true,
          // hintText: inerHint,
          hintStyle: const TextStyle(color: AppColors.textGray),
          floatingLabelStyle: currentState!
              ? AppStyles.subHeading.copyWith(color: AppColors.primary)
              : AppStyles.subHeading,
          label: Text(
            '$inerHint',
            style: const TextStyle(
                fontSize: 14, color: AppColors.buttonBorderGray),
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
          // contentPadding:
          //     const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
          // Add this property
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
      ),
    );
  }
}
