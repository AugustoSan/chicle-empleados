import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String? Function(String?)? validator;
  final bool? enabled;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? maxLength;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final bool obscureText;
  final bool readOnly;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? padding;
  final InputBorder? border;
  final Color? fillColor;
  final bool filled;

  const TextFieldCustom({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    this.enabled,
    this.keyboardType,
    this.maxLines = 1,
    this.maxLength,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.readOnly = false,
    this.autofocus = false,
    this.textInputAction,
    this.focusNode,
    this.padding,
    this.border,
    this.fillColor,
    this.filled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled ?? true,
        readOnly: readOnly,
        obscureText: obscureText,
        autocorrect: false,
        enableSuggestions: !obscureText,
        keyboardType: keyboardType ?? TextInputType.text,
        maxLines: obscureText ? 1 : maxLines,
        maxLength: maxLength,
        autofocus: autofocus,
        textInputAction: textInputAction,
        focusNode: focusNode,
        onChanged: onChanged,
        onTap: onTap,
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
        validator: validator,
        decoration: InputDecoration(
          labelText: title,
          hintText: hintText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: border ?? const OutlineInputBorder(),
          fillColor: fillColor,
          filled: filled,
          contentPadding: const EdgeInsets.all(12.0),
          counterText: maxLength != null ? null : '',
        ),
      ),
    );
  }
}