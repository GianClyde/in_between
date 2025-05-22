import 'package:flutter/material.dart';
import 'package:in_between/core/widgets/images.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ImagePaths.bg.path),
          fit: BoxFit.cover)
      ),
      child: child,
    );
  }
}