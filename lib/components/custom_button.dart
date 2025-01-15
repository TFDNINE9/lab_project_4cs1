import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String titleButton;
  final VoidCallback? onTap;
  final Color colorButton;
  final EdgeInsetsGeometry padding;
  final TextStyle textStyle;
  final double borderRadius;
  final double elevation;
  final double height;
  final double width;

  const CustomButton({
    super.key,
    required this.titleButton,
    this.onTap,
    required this.colorButton,
    this.padding = const EdgeInsets.symmetric(vertical: 16),
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 18),
    this.borderRadius = 30.0,
    this.elevation = 5.0,
    this.height = 54.0,
    this.width = 200.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: colorButton,
          elevation: elevation,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: Size(width, height),
          fixedSize: Size(width, height),
        ),
        child: Text(
          titleButton,
          style: textStyle,
        ),
      ),
    );
  }
}
