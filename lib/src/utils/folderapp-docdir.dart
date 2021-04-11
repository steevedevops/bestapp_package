import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future<String> folderInAppDocDir(String folderName) async {
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  final Directory _appDocDirFolder =  Directory('${_appDocDir.path}/$folderName/');
  if(await _appDocDirFolder.exists()){ //if folder already exists return path
    return _appDocDirFolder.path;
  }else{//if folder not exists create folder and then return its path
    final Directory _appDocDirNewFolder = await _appDocDirFolder.create(recursive: true);
    return _appDocDirNewFolder.path;
  }
}