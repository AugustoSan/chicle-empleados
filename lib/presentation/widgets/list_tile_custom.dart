import 'dart:io';
import 'package:flutter/material.dart';

class ListTileCustom extends StatelessWidget {
  // final MenuItem item;
  final String title;
  final Widget subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final String? imageUrl;

  const ListTileCustom({super.key, required this.title, required this.subtitle, required this.onTap, this.trailing, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final bool mostrarImagen =
        imageUrl != null && File(imageUrl!).existsSync();

    return ListTile(
      onTap: onTap,
      leading: mostrarImagen ? Image.file(File(imageUrl!), width: 40, height: 40) : const SizedBox.shrink(),
      title: Text(title),
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
