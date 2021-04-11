import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

Future<Uint8List> getBytesFromAsset(String path, int width) async {
  // https://stackoverflow.com/questions/53633404/how-to-change-the-icon-size-of-google-maps-marker-in-flutter
  ByteData data = await rootBundle.load(path);
  ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
  ui.FrameInfo fi = await codec.getNextFrame();
  return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
}