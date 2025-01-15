


import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

import '../../../../base/utils/namespase/app_colors.dart';

class NeumorphicWidget extends StatelessWidget {
 final Widget child;
 final VoidCallback? onTap;
 final double? depth;
 final double? intensity;
 final NeumorphicShape shape;
 final NeumorphicBoxShape boxShape;
 final Color? color;

 const NeumorphicWidget({
  Key? key,
  required this.child,
  this.onTap,
  this.depth,
  this.intensity,
  this.shape = NeumorphicShape.flat, // Default shape
  required this.boxShape, // Accept shape type (circle, rectangle)
  this.color,
 }) : super(key: key);

 @override
 Widget build(BuildContext context) {
  return Neumorphic(
   style: NeumorphicStyle(
    depth: depth ?? 5, // Default dynamic depth
    intensity: intensity ?? 0.6, // Default dynamic intensity
    shape: shape, // Dynamic shape (concave, convex, flat)
    color: color ?? AppColors.attendanceBgColor1,
    boxShape: boxShape, // Circle, rounded rectangle, etc.
    lightSource: LightSource.topLeft,oppositeShadowLightSource: false,shadowLightColorEmboss: AppColors.white ,
   ),
   child: GestureDetector(
    onTap: onTap,
    child: child,
   ),
  );
 }
}


class NeumorphicStyles {
 // Button style
 static NeumorphicStyle neuMorphicButtonStyle({
  double depth = 10,
  double intensity = 0.7,
  Color? color,
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(12)),
 }) {
  return NeumorphicStyle(
   depth: depth,
   intensity: intensity,
   color: color ?? AppColors.attendanceBgColor1,
   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
  );
 }

 static NeumorphicStyle neuMorphicButtonStyle2({
  NeumorphicShape shape = NeumorphicShape.concave,
  double depth = -2,
  double intensity = 0.9,
  LightSource lightSource = LightSource.topLeft,
  oppositeShadowLightSource = false,
  shadowLightColorEmboss= AppColors.white ,
 /* LightSource lightSource = LightSource.topLeft, // Default light source*/
  Color? color,
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(12)),
 }) {
  return NeumorphicStyle(
   shape: shape, // Shape of the Neumorphic button
   depth: depth, // Depth effect
   intensity: intensity, // Intensity of the effect
   lightSource: lightSource, // Light source direction
   color: color ?? AppColors.attendanceBgColor1, // Default color
   boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)), // Rounded corners
  );
 }

 // Circle style
 static NeumorphicStyle neuMorphicCircleStyle({
  NeumorphicShape shape = NeumorphicShape.flat,
  double depth = 5,
  double intensity = 0.7,
  Color? color,
 }) {
  return NeumorphicStyle(
   shape: shape,
   depth: depth,
   intensity: intensity,
   color: color ?? AppColors.attendanceBgColor1,
   boxShape: NeumorphicBoxShape.circle(),
  );
 }
}

