import 'package:cook_the_best/audio_schema.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SongCubit extends Cubit<Song>{
  SongCubit(super.initialState);
  void update(Song value){
    emit(value);
  }
}