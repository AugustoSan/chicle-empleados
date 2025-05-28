import 'dart:io';
import 'package:chicle_app_empleados/domain/domain.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Picture {
  Future<String?> saveImage(PictureType type) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if(image != null){
      final appDocDir = await getApplicationDocumentsDirectory();
      // final fileName = p.basename(image.path);
      String folder = '';
      switch (type) {
        case PictureType.profile:
          folder = 'profile';
          break;
        case PictureType.data:
          folder = 'data';
          break;
        case PictureType.business:
          folder = 'business';
          break;
      }
      // 2) Define una subcarpeta (por ejemplo "data" o "images")
      final targetDir = Directory(p.join(appDocDir.path, folder));
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }

      final fileName = p.basename(image.path);
      final destPath = p.join(targetDir.path, fileName);

      // final destPath = p.join(appDocDir.path, folder, fileName);

      final newFile = await File(image.path).copy(destPath);
  
      return newFile.path;
    }
    return null;
  }
}
