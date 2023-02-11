import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color ? color;
  final double? borderRadius;
  final BorderRadius? customborderRadius;
  final bool? customRadius;
  final Widget? child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color shadowColor;
  final double shadowBlurRadious;
  final double spreadRadius;
  final Border ? border;
  final Gradient ? gradient;
  final DecorationImage ? decorationImage;

  const CommonContainer({
    Key? key,
    this.height = 55,
    this.width = double.infinity,
     this.color,
    this.borderRadius = 10,
    this.child,
    this.padding,
    this.margin,
    this.customborderRadius,
    this.customRadius = false,
    this.shadowColor = Colors.transparent,
    this.shadowBlurRadious = 0.0,
    this.spreadRadius = 0.0, this.border, this.gradient, this.decorationImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: customRadius == true
            ? customborderRadius
            : BorderRadius.circular(borderRadius!),
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: shadowBlurRadious,
              spreadRadius: spreadRadius,)
        ],
        gradient: gradient,
        border: border,
        image: decorationImage,
      ),
      child: child,
    );
  }
}
