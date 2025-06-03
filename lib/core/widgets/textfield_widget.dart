import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? tag;
  final TextEditingController controller;
  final bool isDigitOnly;
  const TextFieldWidget({
    super.key,
    required this.label,
    this.tag,
    required this.controller,
    required this.isDigitOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(tag ?? ''),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextField(
              controller: controller,
              inputFormatters:
                  isDigitOnly
                      ? [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ]
                      : [LengthLimitingTextInputFormatter(50)],
              decoration: InputDecoration(
                hintText: label,
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//onTapOutside	PointerDownEventListener?	Called when tapped outside.
//obscureText	bool	Hides input text (e.g., password).
//obscuringCharacter	String	Character used to obscure text (default is •).