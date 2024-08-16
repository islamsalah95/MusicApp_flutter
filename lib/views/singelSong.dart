import 'package:flutter/material.dart';
import 'package:menue/constant/constant.dart';
import 'package:menue/models/Musics.dart';
import 'package:menue/widges/SongWidget.dart';
import 'package:audioplayers/audioplayers.dart';

class Singelsong extends StatefulWidget {
  final int? selectedSongIndex;

  const Singelsong({super.key, required this.selectedSongIndex});

  @override
  State<Singelsong> createState() => _SingelsongState();
}

class _SingelsongState extends State<Singelsong> {
  bool isSongPlaying = false;

  @override
  Widget build(BuildContext context) {
    ScreenSize.initi(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Song Details'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child:
            widget.selectedSongIndex != null && widget.selectedSongIndex! >= 0
                ? SongWidget(
                    audioSource:
                        AssetSource(songsList[widget.selectedSongIndex!].path),
                    name: songsList[widget.selectedSongIndex!].name,
                    singer: songsList[widget.selectedSongIndex!].singer,
                    image: songsList[widget.selectedSongIndex!].image,
                    isSelected: true,
                    onSelect: () {
                      setState(() {
                        isSongPlaying = true;
                      });
                    },
                    onPlayStateChanged: (isPlaying) {
                      setState(() {
                        isSongPlaying = isPlaying;
                        if (!isPlaying) {
                          widget.selectedSongIndex;
                        }
                      });
                    },
                    selectSong: widget.selectedSongIndex)
                : const Center(
                    child: Text(
                      'No song selected.',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
      ),
    );
  }
}
