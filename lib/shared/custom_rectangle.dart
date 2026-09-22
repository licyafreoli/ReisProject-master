import 'package:flutter/material.dart';

class CustomRectangle extends StatelessWidget {

  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final Color? color;
  final double? bordeusRadius;

  const CustomRectangle({
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.color,
    this.bordeusRadius = 12,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width:  width ?? 328,
        decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: BorderRadius.circular(bordeusRadius!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 6),
              blurRadius: 6
            )
          ]
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(50),
          child: child,
        ),
      ),
    );
  }
}