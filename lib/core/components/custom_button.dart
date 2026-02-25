import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  final Color color;
  final Color hoverColor;

  final Color textColor;
  final Color? hoverTextColor;

  final double fontSize;
  final double height;
  final double width;
  final double radius;
  final double borderWidth;
  final Color borderColor;
  final Color? hoverBorderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.color,
    required this.hoverColor,
    required this.textColor,
    required this.hoverTextColor,
    required this.fontSize,
    required this.height,
    required this.width,
    required this.radius,
    required this.borderWidth,
    required this.borderColor,
    this.hoverBorderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) return hoverColor;
            return color;
          }),

          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) return hoverTextColor;
            return textColor;
          }),

          shape: MaterialStateProperty.resolveWith((states) {
            final c = states.contains(MaterialState.hovered)
                ? (hoverBorderColor ?? borderColor)
                : borderColor;

            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: c, width: borderWidth),
            );
          }),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
