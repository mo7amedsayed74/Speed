import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType boardType;
  final String label;
  final String? hintText;
  final IconData prefix;
  final ValueChanged<String>? onChanged;
  //final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final void Function()? onTap;
  final IconData? suffix;
  final bool obscure;
  final Function()? suffixPressed;

  const DefaultTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefix,
    this.hintText,
    this.boardType = TextInputType.text,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.suffix,
    this.obscure = false,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      keyboardType: boardType,
      onTap: onTap,
      onSubmitted: onSubmit,
      onChanged: onChanged,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),

        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: defaultColor!),
        ),

        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),

        // border: UnderlineInputBorder(
        //    borderRadius: BorderRadius.circular(20),
        //    borderSide: BorderSide(color: defaultColor!),
        // ),
        labelText: label,
        hintText: hintText,
        prefixIcon: Icon(
          prefix,
          color: defaultColor,
        ),
        suffixIcon: suffix != null
            ? IconButton(onPressed: suffixPressed, icon: Icon(suffix),color: defaultColor,)
            : null,
      ),
    );
  }
}
