import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType boardType;
  final String label;
  final IconData prefix;
  final String? Function(String?)? validate;
  final ValueChanged<String>? onChanged;
  //final void Function(String)? onChange;
  final void Function(String)? onSubmit;
  final void Function()? onTap;
  final IconData? suffix;
  final bool obscure;
  final Function()? suffixPressed;

  const DefaultTextFormField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefix,
    this.boardType = TextInputType.text,
    this.validate,
    this.onChanged,
    this.onSubmit,
    this.onTap,
    this.suffix,
    this.obscure = false,
    this.suffixPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      keyboardType: boardType,
      onTap: onTap,
      onFieldSubmitted: onSubmit,
      onChanged: onChanged,
      validator: validate!,
      decoration: InputDecoration(
        //contentPadding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: Colors.grey),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: defaultColor!),
          borderRadius: BorderRadius.circular(20),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: defaultColor!),
        ),
        labelText: label,
        //enabled: false,

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
