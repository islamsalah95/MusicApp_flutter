import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:menue/widges/SongWidget.dart';
import 'package:menue/constant/constant.dart';
import 'package:menue/models/Musics.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int? selectedSongIndex = -1;
  bool isSongPlaying = false;

  @override
  Widget build(BuildContext context) {
    ScreenSize.initi(context);

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        width: ScreenSize.width,
        height: ScreenSize.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage("assets/images/bg.jpg"),
          ),
          color: Colors.black,
        ),
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: ScreenSize.width,
                height: ScreenSize.height / 1.5,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Color(0xFF0c091c),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: songsList.length,
                        itemBuilder: (context, index) {
                          return SongWidget(
                              audioSource: AssetSource(songsList[index].path),
                              name: songsList[index].name,
                              singer: songsList[index].singer,
                              image: songsList[index].image,
                              isSelected: selectedSongIndex == index,
                              onSelect: () {
                                setState(() {
                                  selectedSongIndex = index;
                                  isSongPlaying = true;
                                });
                              },
                              onPlayStateChanged: (isPlaying) {
                                setState(() {
                                  isSongPlaying = isPlaying;
                                  if (!isPlaying) {
                                    selectedSongIndex = -1;
                                  }
                                });
                              },
                              selectSong: index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: ScreenSize.height / 3.5,
              right: ScreenSize.width / 10,
              child: CircleAvatar(
                radius: ScreenSize.width / 12,
                backgroundColor: Colors.blue,
                child: Icon(
                  isSongPlaying ? Icons.pause : Icons.music_note,
                  color: Colors.white,
                  size: ScreenSize.width / 10,
                ),
              ),
            ),
            Positioned(
              top: ScreenSize.height / 4,
              left: ScreenSize.width / 10,
              child: Column(
                children: [
                  Text(
                    selectedSongIndex != null && selectedSongIndex! >= 0
                        ? songsList[selectedSongIndex!].singer
                        : '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    selectedSongIndex != null && selectedSongIndex! >= 0
                        ? songsList[selectedSongIndex!].name
                        : '',
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
