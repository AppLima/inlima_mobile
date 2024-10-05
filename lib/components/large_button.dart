import 'package:flutter/material.dart';
import 'package:inlima_mobile/configs/colors.dart';

class LargeButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Color? textColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;

  const LargeButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.textColor,
    this.backgroundColor,
    this.borderRadius,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,  // Se mantiene el valor por defecto de `double.infinity` si no se especifica el width
      height: height ?? 30.0,  // Si no se especifica el height, se usa 30 píxeles por defecto
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? AppColors.primaryColorInlima),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
          )),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: textColor ?? AppColors.textColorWhite),
        ),
      ),
    );
  }
}
