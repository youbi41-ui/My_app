import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class PhotoService {
  Future<String?> savePhoto(XFile photo) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'field_camera_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final savePath = '${dir.path}/$fileName';

      await photo.saveTo(savePath);
      return savePath;
    } catch (_) {
      return null;
    }
  }
}