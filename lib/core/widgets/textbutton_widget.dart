import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color textColor;
  const TextButtonWidget({
    super.key,
    required this.label,
    required this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: TextStyle(color: textColor)),
    );
  }
}
