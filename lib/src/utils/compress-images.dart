import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

Future <File> compressImages(String pathImages, int qualityImage) async {
  print("Start compress");
  var tmpDir = (await getTemporaryDirectory()).path;
  final target = "$tmpDir/${DateTime.now().millisecondsSinceEpoch}.jpg";
  File imagecompress = await FlutterImageCompress.compressAndGetFile(pathImages, target, quality: qualityImage);
  return imagecompress;
}