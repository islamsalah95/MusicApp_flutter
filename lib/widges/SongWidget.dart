import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:menue/constant/constant.dart';
import 'package:menue/views/singelSong.dart';

class SongWidget extends StatefulWidget {
  final AssetSource audioSource;
  final String name;
  final String singer;
  final String image;
  final bool isSelected;
  final VoidCallback onSelect;
  final ValueChanged<bool> onPlayStateChanged;
  final int? selectSong;

  const SongWidget({
    super.key,
    required this.audioSource,
    required this.name,
    required this.singer,
    required this.image,
    required this.isSelected,
    required this.onSelect,
    required this.onPlayStateChanged,
    required this.selectSong,
  });

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  bool isPlaying = false;
  bool hasStarted = false;
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
      widget.onPlayStateChanged(isPlaying);
    });

    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.initi(context);

    return GestureDetector(
      onTap: () {
        widget.onSelect();
      },
      child: Container(
        color: widget.isSelected
            ? Colors.blue.withOpacity(0.2)
            : Colors.transparent,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  width: ScreenSize.width / 5,
                  height: ScreenSize.height / 5,
                ),
                Column(
                  children: [
                    Text(
                      widget.singer,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  formatDuration(position),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  formatDuration(duration),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: (value) async {
                await player.seek(Duration(seconds: value.toInt()));
              },
            ),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: IconButton(
                onPressed: () async {
                  if (widget.isSelected) {
                    if (isPlaying) {
                      await player.pause();
                    } else {
                      if (hasStarted) {
                        await player.resume();
                      } else {
                        await player.play(widget.audioSource);
                        hasStarted = true;
                      }
                    }
                  } else {
                    // Navigate to Singelsong page when the icon is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            Singelsong(selectedSongIndex: widget.selectSong),
                      ),
                    );
                  }
                },
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    return duration.toString().split('.').first.substring(2, 7);
  }
}
