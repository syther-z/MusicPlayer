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
    currentDurationUpdate();
  }


  void setMusic(Song song){
    cSong = song;
    audio.setUrl(song.path!);
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
    play();
  }

  void playPrevious(){
    int preIdx = (cSong!.idx! + defaultHome.state.length - 1) % defaultHome.state.length;
    cSong = defaultHome.state[preIdx];
    currentSong.update(cSong!);
    setMusic(defaultHome.state[preIdx]);
    play();
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

  double toPoint(Duration duration){
      return duration.inSeconds / cSong!.length! * 100;
  }

  void currentDurationUpdate(){
    audio.positionStream.listen((data){
      var p = toPoint(data);
      if(p >= 100){
        // audio.stop();
        playNext();
      }
      playedCubit.update(durationToString(data));
      sliderCubit.update(p);
    });
  }

  static String durationToString(Duration duration){
    // print(duration.toString());
    int d = duration.inSeconds;
    String s = "";
    int hours = (d / 3600).toInt();
    if(hours != 0) s += '$hours:';
    d %= 3600;
    int minutes = (d / 60).toInt();
    if(minutes < 10) s += '0';
    s += '$minutes:';
    d %= 60;
    int seconds = (d).toInt();
    if(seconds < 10) s += '0';
    s += '$seconds';
    return s;
  }
}