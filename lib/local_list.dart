import 'package:cook_the_best/home_cubit.dart';
import 'package:cook_the_best/song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalList extends StatelessWidget {
  const LocalList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DefaultHome, List>(
      builder: (context, state) => ListView.builder(
        itemCount: state.length,
        itemBuilder: (context, index) => SongCard(
          height: 70,
          audio: context.read<DefaultHome>().state[index],
          index: index,
        ),
      ),
    );
  }
}