import 'package:flutter/material.dart';
import 'package:in_between/core/widgets/textfield_widget.dart';

// ignore: must_be_immutable
class NameAgeTxtField extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController birthdateController;

  const NameAgeTxtField({
    super.key,
    required this.nameController,
    required this.birthdateController,
  });

  @override
  State<NameAgeTxtField> createState() => _NameAgeTxtFieldState();
}

class _NameAgeTxtFieldState extends State<NameAgeTxtField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFieldWidget(
                controller: widget.nameController,
                tag: 'Name',
                label: 'Input Name',
              ),
            ),
            SizedBox(width: 15),

            SizedBox(
              width: 90,
              child: TextFieldWidget(
                controller: widget.birthdateController,
                tag: 'Birthdate',
                label: 'Input Birthdate',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
