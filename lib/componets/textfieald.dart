import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonTextfieald extends StatelessWidget {
  final prefixicon;
  final hinttext;
  final TextEditingController? controller;
  final keyboardtype;
  final suffix;
  final String? Function(String? value)? validator;
  final void Function(String)? onchanged;
  final bool obsecuretext;
  final bool? inputunderline;
  final inputformatters;
  final bool ? filled;
  final Color ? fillcolor;
  final double? fontsize;
  final TextInputAction? textInputAction;
  final void Function(String)? onSubmitted;
  final String? initialValue;
  final double? borderradious;
  final EdgeInsetsGeometry? conentpading;

  const CommonTextfieald(
      {Key? key,
      this.prefixicon,
      this.hinttext,
      this.controller,
      this.keyboardtype,
      this.suffix,
      this.obsecuretext = false,
      this.validator,
      this.onchanged,
      this.inputunderline = true,
      this.inputformatters,
      this.fontsize = 15, this.filled, this.fillcolor, this.textInputAction, this.onSubmitted, this.initialValue, this.borderradious = 0.1, this.conentpading,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onchanged,
      onFieldSubmitted: onSubmitted ,
      keyboardType: keyboardtype,
      textInputAction: textInputAction,
      inputFormatters: inputformatters,
      obscureText: obsecuretext,
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        prefixIcon: prefixicon,
        suffixIcon: Padding(padding: EdgeInsets.only(top: 0), child: suffix),
        hintText: hinttext,
        filled: filled,
        fillColor: fillcolor,
        hintStyle: TextStyle(fontFamily: "DmSansRegular", fontSize: fontsize,color: Colors.grey.withOpacity(0.5)),
        contentPadding: conentpading,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(borderradious!))
      ),
    );
  }
}
