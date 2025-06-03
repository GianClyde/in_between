import 'package:flutter/material.dart';

class BorderedText extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isEditable;
  const BorderedText({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isEditable,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.only(left: 8.0),
      width: screenWidth,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(fontSize: 20, color: Colors.white)),
          isEditable
              ? Container(
                width: 30,
                color: Colors.white,
                child: IconButton(
                  onPressed: onPressed,
                  icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black,
                  ),
                ),
              )
              : SizedBox(),
        ],
      ),
    );
  }
}
