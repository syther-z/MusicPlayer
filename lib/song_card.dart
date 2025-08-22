import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/player_cubit.dart';
import 'package:cook_the_best/song_cubit.dart';
import 'package:cook_the_best/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SongCard extends StatelessWidget {
  final Song? audio;
  final double? height;
  final int index;

  SongCard({super.key, required this.audio, this.height, required this.index}) {
    audio!.idx = index;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongCubit, Song>(
      builder:
          (context, state) => GestureDetector(
            onTap: () {
              if(context.read<SongCubit>().state.idx != index){
                print('${context.read<SongCubit>().state.idx}  $index');
                context.read<SongCubit>().update(audio!);
                context.read<PlayerLogic>().state.setMusic(audio!);
                context.read<PlayerLogic>().state.play();
              }
              
              context.push('/player/$index');
              
            },
            child: Container(
              height: height ?? 70,
              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: context.read<SongCubit>().state.idx == index ? selectedCard : cardColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  // Album Art / Placeholder Icon
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: iconColor,
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Song Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          audio!.title!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Artist ${index + 1}", // placeholder artist name
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Options Button
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.more_vert, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
