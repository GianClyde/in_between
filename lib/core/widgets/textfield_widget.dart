import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? tag;
  final TextEditingController controller;
  const TextFieldWidget({
    super.key,
    required this.label,
    this.tag,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(tag ?? ''),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
