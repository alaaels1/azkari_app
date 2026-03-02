import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  final Color? color;
  final Color? hoverColor;

  final Color? textColor;
  final Color? hoverTextColor;

  final double fontSize;
  final double height;
  final double width;
  final double radius;
  final double borderWidth;
  final Color? borderColor;
  final Color? hoverBorderColor;

  const CustomButton({
    super.key,
    required this.text,
    this.color,
    this.hoverColor,
    this.textColor,
    this.hoverTextColor,
    required this.fontSize,
    required this.height,
    required this.width,
    this.radius = 8,
    this.borderWidth = 0,
    this.borderColor,
    this.hoverBorderColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final defaultColor = color ?? theme.cardColor;
    final defaultHoverColor = hoverColor ?? theme.colorScheme.primary.withOpacity(0.1);
    final defaultTextColor = textColor ?? theme.textTheme.bodyLarge?.color;
    final defaultBorderColor = borderColor ?? Colors.transparent;

    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          elevation: const MaterialStatePropertyAll(3),

          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return defaultHoverColor;
            }
            return defaultColor;
          }),

          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.hovered)) {
              return hoverTextColor ?? defaultTextColor;
            }
            return defaultTextColor;
          }),

          shape: MaterialStateProperty.resolveWith((states) {
            final c = states.contains(MaterialState.hovered)
                ? (hoverBorderColor ?? defaultBorderColor)
                : defaultBorderColor;

            return RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: c, width: borderWidth),
            );
          }),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}