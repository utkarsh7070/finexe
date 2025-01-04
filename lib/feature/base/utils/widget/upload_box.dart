import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../namespase/font_size.dart';

class UploadBox extends StatelessWidget {
  final bool isImage;
  final IconData? iconData;
  final String? title;
  final String? subTitle;
  final Color? color;
  final bool isError;
  final Color? errorColor;
  final Color? subTextColor;
  final Color? textColor;
  final double? height;
  final double? width;

  const UploadBox({super.key,
    this.isError = false,
    this.errorColor,
    required this.iconData,
    this.title,
    this.subTitle,
    this.color,
    this.height,
    this.width,
    this.subTextColor,
    this.textColor, this.isImage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      height: height ?? displayHeight(context) * 0.15,
      width: width ?? displayWidth(context) * 0.40,
      decoration:  BoxDecoration(
          border: DashedBorder.fromBorderSide(
            dashLength: 10,
            side: BorderSide(color: isError?Colors.red:Colors.black, width: 1),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: AppColors.boxBagGray),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isImage ? Image.asset(
              'assets/images/image.png', height: 36, width: 36,) : Icon(
              iconData,
              color: color,
            ),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Text(subTitle!,
            textAlign: TextAlign.center,
                style: AppStyles.subTextStyle.copyWith(color: subTextColor)),

            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Text(title!,
                style: AppStyles.subTextStyle.copyWith(
                    fontSize: FontSize.fontSizeXSs, color: textColor)),
          ],
        ),
      ),
    );
  }
}
