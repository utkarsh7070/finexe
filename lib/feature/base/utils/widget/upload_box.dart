import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

import '../namespase/font_size.dart';

class UploadBox extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final String? subTitle;
  final Color? color;
  final Color? subTextColor;
  final Color? textColor;
  final double? height;
  final double? width;

  const UploadBox(
      {super.key,
      required this.iconData,
      this.title,
      this.subTitle,
      this.color,
      this.height,
      this.width,
      this.subTextColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: height ?? displayHeight(context) * 0.15,
      width: width ?? displayWidth(context) * 0.40,
      decoration: const BoxDecoration(
          border: DashedBorder.fromBorderSide(
            dashLength: 10,
            side: BorderSide(color: Colors.black, width: 1),
          ),
          borderRadius: BorderRadius.all(Radius.circular(21)),
          color: AppColors.boxBagGray),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color: color,
            ),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Text(title!,
                style: AppStyles.subTextStyle.copyWith(
                    fontSize: FontSize.fontSizeXSs, color: textColor)),
            SizedBox(
              height: displayHeight(context) * 0.01,
            ),
            Text(subTitle!, style: AppStyles.subTextStyle.copyWith(color: subTextColor)),
          ],
        ),
      ),
    );
  }
}
