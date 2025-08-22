import 'dart:io';

import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/main.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageHandler {
  static Future<bool> handleStoragePermission() async {
    if (await Permission.manageExternalStorage.isGranted) return true;

    var status = await Permission.manageExternalStorage.request();

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  static void getSongs() async {
    Directory d = Directory('/storage/emulated/0/');
    resolveSongs(d);
  }

  static void resolveSongs(Directory d) {
    d.list().forEach((element) {
      if (element is Directory) {
        if (element.path != '/storage/emulated/0/Android/') resolveSongs(element);
      } else if (hasExtension(element, [
        '.mp3',
        '.wav',
        '.flac',
        // '.apk',
      ])) {
        // print(element.path);
        // await Future.delayed(Duration(milliseconds: 1000));
        defaultHome.update([
          ...defaultHome.state,
          Song(path: element.path),
        ]);
      }
    });
  }
  
  static bool hasExtension(FileSystemEntity file, List<String> extensions) {
    if (file is! File) return false;
    String path = file.path.toLowerCase();
    return extensions.any((ext) => path.endsWith(ext));
  }
}
