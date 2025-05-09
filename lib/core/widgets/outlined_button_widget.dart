import 'package:flutter/material.dart';
import 'package:in_between/core/widgets/images.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ButtonWidget({super.key, required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: 148,
        child: Stack(
          children: [
            Image.asset(ImagePaths.blackBtn.path, fit: BoxFit.cover),
            Center(
              heightFactor: 1.5,
              child: Text(
                label,
                style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
