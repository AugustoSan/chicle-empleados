import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyTile extends StatelessWidget {
  final Uri privacyUri = Uri.parse(
    'https://augustosan.github.io/chicle-empleados/'
  );

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.privacy_tip),
      title: const Text('Política de privacidad'),
      onTap: () async {
        if (!await launchUrl(privacyUri, mode: LaunchMode.externalApplication)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No se pudo abrir la política.'))
          );
        }
      },
    );
  }
}
