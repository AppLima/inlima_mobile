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
      width: width ?? double.infinity,  // Ancho por defecto
      height: height ?? 50.0,  // Altura por defecto
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? AppColors.primaryColorInlima),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: borderRadius ?? BorderRadius.circular(5),
          )),
        ),
        onPressed: onPressed,
        child: Center(  // Asegura que el contenido del botón esté centrado
          child: Text(
            title,
            style: TextStyle(
              color: textColor ?? AppColors.textColorWhite,
              fontSize: 16,  // Tamaño del texto ajustado (puedes modificarlo)
            ),
            textAlign: TextAlign.center,  // Asegura que el texto esté centrado
          ),
        ),
      ),
    );
  }
}
