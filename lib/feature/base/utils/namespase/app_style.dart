import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'font_size.dart';
import 'fonts.dart';

extension AppStyles on Never {
  static TextStyle buttonDarkTextStyle = TextStyle(
    color: AppColors.black,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w300,
    fontSize: FontSize.fontSize,
  );
  static TextStyle subHeading = TextStyle(
    color: AppColors.gray,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.fontSizeS,
  );
  static TextStyle subHeadingW500 = TextStyle(
    color: AppColors.titleGray,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w500,
    fontSize: FontSize.fontSizeS,
  );
  static TextStyle termsConditionText = TextStyle(
    color: AppColors.textDarkGray,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.fontSizeXSs,
  );
  static TextStyle nameText = TextStyle(
    color: AppColors.textDarkGray,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w500,
    fontSize: FontSize.fontSizeSL,
  );
  static TextStyle subTextStyle = TextStyle(
    color: AppColors.subTextColor,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.fontSizeXS,
  );

  static TextStyle buttonLightTextStyle = TextStyle(
    color: AppColors.white,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w300,
    fontSize: FontSize.fontSize16,
  );


  static TextStyle cardTextStyle16 = TextStyle(
    color: AppColors.grayCardContentColor,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.fontSize16,
  );
  static TextStyle TextStyle16 = TextStyle(
    color: AppColors.black,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.fontSize16,
  );

  static TextStyle headingTextStyle = TextStyle(
    color: AppColors.black,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.fontSizeS,
  );
  static TextStyle headingTextStyleFooter = TextStyle(
    color: AppColors.gray,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w400,
    fontSize: FontSize.fontSizeS,
  );
  static TextStyle headingTextStyle2 = TextStyle(
    color: AppColors.black,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w500,
    fontSize: FontSize.fontSizeXXL,
  );
  static TextStyle headingTextStyleXL = TextStyle(
    color: AppColors.black,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.fontSizeXXXL,
  );

  static TextStyle headingTextStyleXL1 = TextStyle(
    color: AppColors.primary,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w700,
    fontSize: FontSize.fontSizeXXXL,
  );
  static TextStyle headingTextStyleXL2 = TextStyle(
    color: AppColors.orange,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w600,
    fontSize: FontSize.fontSizeL,
  );

  static TextStyle smallTextStyle = TextStyle(
    color: AppColors.grayDark,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w100,
    fontSize: FontSize.fontSizeXSs,
  );
  static TextStyle smallTextStyleRich = TextStyle(
    color: AppColors.primary,
    fontFamily: Fonts.appFonts,
    fontWeight: FontWeight.w100,
    fontSize: FontSize.fontSizeXSs,
  );

}