import 'package:finexe/feature/base/utils/namespase/app_colors.dart';
import 'package:finexe/feature/base/utils/namespase/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppButton extends StatelessWidget {
  const AppButton({
    String? label,
    VoidCallback? onTap,
    bool? isFill,
    double? height,
    Color? bgColor,
    Color? borderColor,
    double? width,
    TextStyle? textStyle,
    bool? isDisabled,
    super.key,
  }) : _label = label,
        _onTap = onTap,
        _isFill = false,
        _height = height,
        _width = width,
        _textStyle = textStyle,
        _isDisabled = false,
        _bgColor = bgColor,
        _borderColor = borderColor;


  final String? _label;
  final VoidCallback? _onTap;
  final bool _isFill;
  final double? _height;
  final double? _width;
  final TextStyle? _textStyle;
  final bool? _isDisabled;
  final Color? _bgColor;
  final Color? _borderColor;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _height,
      width: _width,
      child: ElevatedButton(
        style: _isFill
            ? ElevatedButton.styleFrom(
          backgroundColor: _bgColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: _borderColor!),
            borderRadius: BorderRadius.circular(10),
          ),
        )
            : ElevatedButton.styleFrom(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: _isDisabled! ? null : _onTap,
        child: Text(
          _label!,
          style: _isFill ? AppStyles.buttonLightTextStyle : _textStyle,
        ),
      ),
    );
  }
// @override
// Widget build(BuildContext context) {
// return SizedBox(
// width: MediaQuery.of(context).size.width,
// child: ElevatedButton(
// style: ElevatedButton.styleFrom(),
// onPressed: _isDisabled! ? null : _onTap,
// child: Text(
// _label!,
// style: _isFill! ? AppStyles.buttonLightTextStyle : _textStyle,
// ),
// // child: Text('$text',style: AppStyles.buttonLightTextStyle,)),
// );
// }
}