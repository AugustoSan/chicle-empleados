import 'package:chicle_app_empleados/domain/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyTile extends StatelessWidget {
  final Uri privacyUri = Uri.parse(
    apiUrl + 'privacy.html'
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
