import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultMaterialButton extends StatelessWidget {
  final String text;
  final Function() onPressedFunction;
  final Color? background;
  final double width;

  const DefaultMaterialButton({
    super.key,
    required this.text,
    required this.onPressedFunction,
    this.background,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        color: background ?? defaultColor,
      ),
      child: MaterialButton(
        onPressed: onPressedFunction,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
