import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultTextButton extends StatelessWidget {
  final String text;
  final Function() onPressedFunction;
  final Color? textColor;

  const DefaultTextButton({
    super.key,
    required this.text,
    required this.onPressedFunction,
    this.textColor, // defaultColor = Colors.blue[900];
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedFunction,
      child: Text(
        text,
        style: TextStyle(
          fontStyle: FontStyle.italic,
          color: textColor ?? defaultColor,
        ),
      ),
    );
  }
}
