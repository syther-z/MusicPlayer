import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:audio_metadata_reader/audio_metadata_reader.dart';
class Song{
  int? idx;
  String title = 'unknown';
  String? path;
  String artist = 'unknown';
  String album = 'unknown';
  int? length = 0;
  Song({this.idx, this.path, this.length}){
    if(path != null){
    AudioMetadata data = readMetadata(File(path!), getImage: false);
    // print('\n\n\n\n\n');
    title = data.title ?? getName(path!);
    artist = data.artist ?? artist;
    album = data.album ?? album;
    length = data.duration!.inSeconds;
    }
  }
  static String getName(String path){
    var temp = path.split(RegExp('[/]'));
    return temp[temp.length-1];
  }
  String fixEncoding(String garbled) {
  // Convert garbled string back to raw bytes
  final bytes = Uint8List.fromList(garbled.codeUnits);
  // Decode as UTF-16
  return utf8.decode(bytes, allowMalformed: true);
}
}