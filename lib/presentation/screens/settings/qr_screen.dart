import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatefulWidget {
  const QrScreen({Key? key}) : super(key: key);
  @override
  State<QrScreen> createState() => _QrScreenState();
}

class _QrScreenState extends State<QrScreen> {
  final List<QrEyeShape> eyeOptions = [QrEyeShape.square, QrEyeShape.circle];
  final List<QrDataModuleShape> moduleOptions = [QrDataModuleShape.square, QrDataModuleShape.circle];

  QrEyeShape selectedEye = QrEyeShape.square;
  QrDataModuleShape selectedModule = QrDataModuleShape.square;
  
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
    String message = apiUrl + 'carta.html';

    var orientation = MediaQuery.of(context).orientation;

    final double qrSize = orientation == Orientation.portrait
        ? MediaQuery.of(context).size.width * 0.6
        : MediaQuery.of(context).size.height * 0.3;
    final double qrHeight = MediaQuery.of(context).size.height * 0.3;

    var image = Image.asset('assets/icon/logo.jpg',);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escaneame'),
      ),
      body: Column(
        children: [
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
              eyeStyle: QrEyeStyle(
                eyeShape: selectedEye,
                color: Colors.black,
              ),
              dataModuleStyle: QrDataModuleStyle(
                dataModuleShape: selectedModule,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Dropdown para tipo de ojos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Ojos: '),
                  DropdownButton<QrEyeShape>(
                    value: selectedEye,
                    items: eyeOptions.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => selectedEye = value);
                    },
                  ),
                ],
              ),

              // Dropdown para tipo de módulos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Módulos: '),
                  DropdownButton<QrDataModuleShape>(
                    value: selectedModule,
                    items: moduleOptions.map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    )).toList(),
                    onChanged: (value) {
                      if (value != null) setState(() => selectedModule = value);
                    },
                  ),
                ],
              ),
        ], 
      ),
    );
  }
}
