import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/home_cubit.dart';
import 'package:cook_the_best/main.dart';
import 'package:cook_the_best/player_cubit.dart';
import 'package:cook_the_best/song_cubit.dart';
import 'package:cook_the_best/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatefulWidget {
  int? idx;
  PlayerPage({required this.idx, super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  // const PlayerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SongCubit, Song>(
      builder: (context, state) => Scaffold(
        backgroundColor: Colors.black, // dark theme like music players
        body: Column(
          children: [
            // Album Art Section
            Container(
              alignment: Alignment.center,
              height: 400,
              color: Colors.black87,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://picsum.photos/300", // placeholder album art
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
      
            // Song Info + Controls Section
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Song title + artist
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 100
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        child: Text(
                          context.read<DefaultHome>().state[widget.idx!].title,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      context.read<DefaultHome>().state[widget.idx!].artist,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 30),
      
                    // Progress bar
                    BlocBuilder<SliderCubit, double>(
                      builder: (context, state) => Slider(
                      
                      value: sliderCubit.state,
                      max: 100,
                      onChanged: (value) {
                        audioPlayer.state.goTo(value);
                      },
                      activeColor: sliderActive,
                      inactiveColor: sliderInactive,
                    ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("1:20", style: TextStyle(color: Colors.white70)),
                        Text("3:45", style: TextStyle(color: Colors.white70)),
                      ],
                    ),
                    const SizedBox(height: 30),
      
                    // Control buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous, size: 40, color: Colors.white),
                          onPressed: () {
                             context.read<PlayerLogic>().state.playPrevious();
                          },
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              context.read<PlayerLogic>().state.toggle();
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: sliderActive,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(!context.read<PlayerLogic>().state.isPlaying ? Icons.play_arrow : Icons.pause, size: 40, color: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.skip_next, size: 40, color: Colors.white),
                          onPressed: () {
                            context.read<PlayerLogic>().state.playNext();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
