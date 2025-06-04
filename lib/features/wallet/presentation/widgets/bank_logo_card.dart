import 'package:flutter/material.dart';
import 'package:in_between/core/widgets/images.dart';

class BankLogoCard extends StatelessWidget {
  final String imagePath;
  const BankLogoCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 100,
        width: 120,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePaths.plainRedBg.path),
            fit: BoxFit.cover,
            opacity: .96,
          ),
          borderRadius: BorderRadius.circular(10),

          border: Border.all(color: Color(0xffffb53d), width: 2),
        ),
        child: Image.asset(imagePath, fit: BoxFit.contain),
      ),
    );
  }
}
