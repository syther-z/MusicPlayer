import 'package:cook_the_best/player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerLogic extends Cubit<Player>{
  PlayerLogic(super.initialState);
  void update(Player player){
    emit(player);
  }
}

class SliderCubit extends Cubit<double>{
  SliderCubit(super.initialState);
  void update(double value){
    emit(value);
  }
}