import 'package:flutter/material.dart';

class TextTitleWithContent extends StatelessWidget {
  final String title;
  final String content;
  const TextTitleWithContent({Key? key, required this.title, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(content)),
      ],
    );
  }
}