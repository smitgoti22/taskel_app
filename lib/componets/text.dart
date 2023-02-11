import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final text;
  final double ? size;
  final color;
  final fontfamily;
  final fontweight;
  final maxlines;
  final textalign;
  final textwrap;
  final overflow;
  final double ? letterspacing;
  final TextDecoration ? textDecoration;

  const CommonText(
      {Key? key,
      required this.text,
      this.size = 14,
      this.fontfamily = "Ubantu",
      this.color,
      this.fontweight, this.maxlines, this.textalign, this.letterspacing, this.textwrap, this.overflow, this.textDecoration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxlines,
      textAlign: textalign,
      softWrap: textwrap,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontFamily: fontfamily,
          fontWeight: fontweight,
        decoration: textDecoration,
        overflow: overflow,
        letterSpacing: letterspacing
      ),
    );
  }
}
