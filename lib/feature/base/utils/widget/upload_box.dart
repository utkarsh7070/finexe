import 'package:dotted_border/dotted_border.dart';
import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/display_size.dart';
import 'package:flutter/material.dart';
import 'package:mobkit_dashed_border/mobkit_dashed_border.dart';

class UploadBox extends StatelessWidget {
  final IconData? iconData;
  final String? title;
  final String? subTitle;
  final Color? color;


  const UploadBox(
      {super.key, required this.iconData, this.title, this.subTitle, this.color});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: displayHeight(context) * 0.15,
        width: displayWidth(context) * 0.40,
        decoration: BoxDecoration(
          border: DashedBorder.fromBorderSide(dashLength: 10, side: BorderSide(color: Colors.black, width: 1),
          ),
            borderRadius: BorderRadius.all(Radius.circular(21)),
            color: AppColors.boxBagGray),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Icon(iconData,color: color,),
            SizedBox(height: displayHeight(context)*0.01,),
            Text(title!),
              SizedBox(height: displayHeight(context)*0.01,),
            Text(subTitle!),
          ],),
        ),
      ),

  }
}
