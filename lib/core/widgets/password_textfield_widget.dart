import 'package:flutter/material.dart';

class PasswordTextfieldWidget extends StatefulWidget {
  final String? tag;
  final String? label;
  final TextEditingController passwordController;

  const PasswordTextfieldWidget({
    super.key,
    this.tag,
    required this.label,
    required this.passwordController,
  });

  @override
  State<PasswordTextfieldWidget> createState() =>
      _PasswordTextfieldWidgetState();
}

class _PasswordTextfieldWidgetState extends State<PasswordTextfieldWidget> {
  // final _formKey = GlobalKey<FormState>();

  bool _hidePassword = true;

  void _togglePassVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.tag ?? ''),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.80,
            child: TextFormField(
              controller: widget.passwordController,
              obscureText: _hidePassword,
              decoration: InputDecoration(
                hintText: widget.label,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: _togglePassVisibility,
                  icon: Icon(
                    _hidePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
