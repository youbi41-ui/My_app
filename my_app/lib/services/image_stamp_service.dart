import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;

class ImageStampService {
  Future<String?> stampImage({
    required String imagePath,
    required List<String> lines,
  }) async {
    try {
      final file = File(imagePath);
      final bytes = await file.readAsBytes();

      final originalImage = img.decodeImage(bytes);
      if (originalImage == null) return null;

      final image = img.copyResize(
        originalImage,
        width: originalImage.width,
      );

      const int padding = 28;
      const int lineHeight = 36;
      const int topBottomPadding = 28;

      final int boxHeight = (lines.length * lineHeight) + topBottomPadding + 20;
      final int boxTop = image.height - boxHeight;

      img.fillRect(
        image,
        x1: 0,
        y1: boxTop,
        x2: image.width,
        y2: image.height,
        color: img.ColorRgba8(0, 0, 0, 175),
      );

      int y = boxTop + padding;

      for (final line in lines) {
        img.drawString(
          image,
          line,
          font: img.arial24,
          x: padding,
          y: y,
          color: img.ColorRgb8(255, 255, 255),
        );
        y += lineHeight;
      }

      final dir = p.dirname(imagePath);
      final name = p.basenameWithoutExtension(imagePath);
      final stampedPath = p.join(dir, '${name}_stamped.jpg');

      final jpg = img.encodeJpg(image, quality: 95);
      await File(stampedPath).writeAsBytes(jpg);

      return stampedPath;
    } catch (_) {
      return null;
    }
  }
}