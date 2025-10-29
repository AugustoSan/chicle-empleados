import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<String?> saveImageFromURL(String url, String fileName) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // Obtener el directorio local de la app
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Guardar la imagen como archivo
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      print('✅ Imagen guardada en: $filePath');
      return filePath;
    } else {
      print('❌ Error al descargar la imagen');
      return null;
    }

  }  
}
