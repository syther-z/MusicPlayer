import 'package:cook_the_best/audio_schema.dart';
import 'package:cook_the_best/player_cubit.dart';
import 'package:cook_the_best/song_cubit.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_cubit.dart';
import 'local_list.dart';
import 'storage_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
    _init();
  }

  Future<void> _init() async {
    bool granted = await StorageHandler.handleStoragePermission();
    if (granted) {
      StorageHandler.getSongs();
    } else {
      debugPrint("Storage permission not granted!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 80,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6D28D9), Color(0xFF9333EA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              // borderRadius: BorderRadius.only(
              //   bottomLeft: Radius.circular(25),
              //   bottomRight: Radius.circular(25),
              // ),
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Icon(Icons.menu, color: Colors.white, size: 28),
                  Text(
                    "Music Player",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(Icons.search, color: Colors.white, size: 28),
                ],
              ),
            ),
          ),

          // Content with Tabs
          Expanded(
            child: Column(
              children: [
                // Tabs
              

                // TabBarView Content
                Expanded(
                  child: TabBarView(
                    controller: _controller,
                    children: [
                      Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(8),
                        child: const LocalList(),
                      ),
                      Container(
                        color: Colors.black,
                        child: const Center(
                          child: Text(
                            "Online Songs Coming Soon",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Mini Player at Bottom
          BlocBuilder<SongCubit, Song>(builder: (context, state) => GestureDetector(
            onTap: (){
              context.push('/player/${context.read<SongCubit>().state.idx}');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Thumbnail
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 50,
                      width: 50,
                      color: Colors.deepPurple,
                      child: const Icon(Icons.music_note, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 12),
            
                  // Song Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          context.read<SongCubit>().state.title ?? "Song Title",
                          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Artist Name",
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
            
                  // Controls
                  IconButton(
                    onPressed: () {
                      context.read<PlayerLogic>().state.playPrevious();
                    },
                    icon: const Icon(Icons.skip_previous, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<PlayerLogic>().state.toggle();
                      });
                    },
                    icon: Icon(context.read<PlayerLogic>().state.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: 30),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<PlayerLogic>().state.playNext();
                    },
                    icon: const Icon(Icons.skip_next, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),),
            Container(
                  // margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    border: Border(top: BorderSide(color: Colors.black, width: 2))
                    // borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    controller: _controller,
                    indicator: BoxDecoration(
                      // color: Colors.deepPurple,
                      // borderRadius: BorderRadius.circular(25),
                      border: Border(bottom: BorderSide(color: Colors.deepPurple, width: 2))
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    tabs: const [
                      Tab(text: "Local"),
                      Tab(text: "Online"),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
