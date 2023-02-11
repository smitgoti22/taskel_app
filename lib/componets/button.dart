import 'package:flutter/material.dart';
import 'package:taskel_app/componets/text.dart';

class CommonButton extends StatelessWidget {
  final double ? height;
  final double ? width;
  final Color? color;
  final void Function()? ontap;
  final borderradious;
  final LinearGradient? linearGradient;
  final String? buttuonText;
  final double? buttuonTextSize;
  final Color? buttuonTextColor;
  final FontWeight? fontWeight;
  final IconData ? icon;
  final Color ? iconColor;
  final double ? iconSize;
  final bool isIcon;

  const CommonButton(
      {Key? key,
      this.height = 55,
      this.color = Colors.green,
      this.ontap,
      this.borderradious = 25.0,
      this.width = double.infinity,
      this.linearGradient,
      this.buttuonText,
      this.buttuonTextSize,
      this.buttuonTextColor,
      this.fontWeight, this.icon, this.iconColor, this.iconSize, this.isIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hight = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderradious),
        gradient: linearGradient,
      ),
      child: MaterialButton(
          onPressed: ontap,
          child: Row(
            mainAxisAlignment: isIcon == true ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              isIcon == true ? Icon(icon,color: iconColor,size: iconSize,) : SizedBox(),
              isIcon == true ? SizedBox(width: width * 0.27,) : SizedBox(),
              CommonText(
                text: buttuonText,
                size: buttuonTextSize,
                color: buttuonTextColor,
                fontweight: fontWeight,
              ),
            ],
          )),
    );
  }
}
