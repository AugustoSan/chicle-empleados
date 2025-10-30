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

    var orientation = MediaQuery.of(context).orientation;

    final double qrSize = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width * 0.6
        : MediaQuery.of(context).size.height * 0.3;
    final double qrHeight = MediaQuery.of(context).size.height * 0.3;

    var image = Image.asset('assets/icon/logo.jpg',);

    return AlertDialog(
      title: const Text(
        'Escaneame',
        style: TextStyle(fontSize: 16),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Caja fija para evitar conflictos de LayoutBuilder
            SizedBox(
              width: qrSize,
              height: qrHeight,
              child: QrImageView(
                data: message,
                version: QrVersions.auto,
                // size: qrSize,
                backgroundColor: Colors.white,
                embeddedImage: image.image,
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(40, 40),
                ),
                eyeStyle: const QrEyeStyle(
                  eyeShape: QrEyeShape.circle,
                  color: Colors.black,
                ),
                dataModuleStyle: const QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.circle,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Consulta la carta escaneando el código QR',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
