import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AlertQrDialog extends StatelessWidget {
  final String message;
  const AlertQrDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Configuración del estilo del sistema (opcional)
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return AlertDialog(
      title: const Text(
        'Consulta la carta escaneando el siguiente código QR',
        style: TextStyle(fontSize: 16),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Caja fija para evitar conflictos de LayoutBuilder
            SizedBox(
              width: 250,
              height: 250,
              child: QrImageView(
                data: message,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: Color(0xff128760),
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: Color(0xff1a5441),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cerrar'),
        ),
      ],
    );
  }
}
