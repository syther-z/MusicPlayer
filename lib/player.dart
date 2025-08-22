import 'dart:math' as Math;

import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/main.dart';
import 'package:just_audio/just_audio.dart';

class Player{
  late AudioPlayer audio;
  bool isPlaying = false;
  Song? cSong;
  Player(){
    audio = AudioPlayer();
  }


  void setMusic(Song song){
    cSong = song;
    audio.setUrl(song.path!);
    currentDuration();
  }

  int duration(){
    return audio.duration!.inMilliseconds;
  }

  void play(){
    audio.play();
    isPlaying = true;
  }

  void pause(){
    audio.pause();
    isPlaying = false;
  }

  void toggle(){
    isPlaying ? audio.pause() : audio.play();
    isPlaying = !isPlaying;
  }

  void playNext(){
    int nextIdx = (cSong!.idx! + 1) % defaultHome.state.length;
    cSong = defaultHome.state[nextIdx];
    currentSong.update(cSong!);
    setMusic(defaultHome.state[nextIdx]);
  }

  void playPrevious(){
    int preIdx = (cSong!.idx! + defaultHome.state.length - 1) % defaultHome.state.length;
    cSong = defaultHome.state[preIdx];
    currentSong.update(cSong!);
    setMusic(defaultHome.state[preIdx]);
  }

  void goTo(double value){
    double point = value / 100 * cSong!.length!;
    audio.seek(toDuration(point.toInt()));
  }

  static Duration toDuration(int value){
     int min = (value / 60).toInt();
     int sec = (value % 60).toInt();
     return Duration(minutes: min, seconds: sec);
  }

  toPoint(Duration duration){
      return duration.inSeconds / cSong!.length! * 100;
  }

  void currentDuration(){
    audio.positionStream.listen((data){
      print(data);
      sliderCubit.update(toPoint(data));
    });
  }

}