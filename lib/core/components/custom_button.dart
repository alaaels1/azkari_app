import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? textColor;
  final Color? hoverShadowColor;
  final Color? borderColor;
  final Color? tintColor;
  final double fontSize;
  final double height;
  final double width;
  final double radius;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.fontSize,
    required this.height,
    required this.width,
    required this.onPressed,
    this.textColor,
    this.hoverShadowColor,
    this.borderColor,
    this.tintColor,
    this.radius = 8,
    this.borderWidth = 1.2,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _hovered = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textColor   = widget.textColor ?? Theme.of(context).textTheme.bodyLarge?.color;
    final borderColor = widget.borderColor ?? Colors.white.withOpacity(0.2);
    final tint        = widget.tintColor ?? Colors.white;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovered = true),
      onExit:  (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        onTapDown:   (_) => setState(() => _pressed = true),
        onTapUp:     (_) => setState(() => _pressed = false),
        onTapCancel: ()  => setState(() => _pressed = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.height,
          width: widget.width,
          transform: _pressed
              ? (Matrix4.identity()..scale(0.97))
              : Matrix4.identity(),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint.withOpacity(_hovered ? 0.45 : 0.3),
            borderRadius: BorderRadius.circular(widget.radius),
            border: Border.all(color: borderColor, width: widget.borderWidth.w),
            boxShadow: [
              BoxShadow(
                color: (widget.hoverShadowColor ?? tint)
                    .withOpacity(_hovered ? 0.35 : 0.12),
                blurRadius: _hovered ? 22.r : 8.r,
                offset: Offset(0, 5.h),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(widget.radius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                color: Colors.white.withOpacity(_hovered ? 0.12 : 0.05),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        widget.text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Alyamama",
                          fontSize: widget.fontSize,
                          fontWeight: FontWeight.bold,
                          color: textColor,
                          letterSpacing: 0.5.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
