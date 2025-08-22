import 'package:cook_the_best/audio_schema.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DefaultHome extends Cubit<List<Song>>{
  DefaultHome(super.initialState);
  get value => state;
  void update(var value){
    emit(value);
  }

}