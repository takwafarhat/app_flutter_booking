import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class MarkerIconMakerMixin {
  //creates custom marker icon using assets image
  static Future<Uint8List> getMakerIconFromAssets(
      String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    return (await frameInfo.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
