import 'package:flutter/material.dart';

class TextFieldCustom extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final bool? enabled;
  final TextInputType? keyboardType;
  const TextFieldCustom({super.key, required this.controller, required this.title, this.validator, this.enabled, this.keyboardType});

  @override
  State<TextFieldCustom> createState() => _TextFieldCustomState();
}

class _TextFieldCustomState extends State<TextFieldCustom> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled ?? true,
      controller: widget.controller,
      enableSuggestions: false,
      autocorrect: false,
      keyboardType: widget.keyboardType ?? TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.title,
      ),
      validator: widget.validator,
    );
  }
}
