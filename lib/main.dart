

import 'package:cook_the_best/Routes/AppRouter.dart';
import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/home_cubit.dart';
import 'package:cook_the_best/home_page.dart';
import 'package:cook_the_best/player.dart';
import 'package:cook_the_best/player_cubit.dart';
import 'package:cook_the_best/song_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main(){
  runApp(const MyApp());
}

var defaultHome = DefaultHome([]);
var audioPlayer = PlayerLogic(Player());
var  currentSong = SongCubit(Song(path: null, idx: -1));
var sliderCubit = SliderCubit(0);
var playedCubit = PlayedCubit('00:00');
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(value: defaultHome),
          BlocProvider.value(value: audioPlayer),
          BlocProvider.value(value: currentSong),
          BlocProvider.value(value: sliderCubit),
          BlocProvider.value(value: playedCubit)
        ],
         child:  SafeArea(
           child: MaterialApp.router(
            routerConfig: Approuter().router,
           ),
         ),
    );
  }
}