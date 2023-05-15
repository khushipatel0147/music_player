import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/musicPlayer/provider/musicProvider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  MusicProvider? providerF;
  MusicProvider? providerT;
  @override
  Widget build(BuildContext context) {
    int index=ModalRoute.of(context)!.settings.arguments as int;
    providerF = Provider.of<MusicProvider>(context, listen: false);
    providerT = Provider.of<MusicProvider>(context, listen: true);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: InkWell(
          onTap: () {
            providerF!.audiostop();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              "PLAYING FOR YOUR LIBRARY",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                letterSpacing: 1,
              ),
            ),
            SizedBox(height: 3),
            Text(
              "Liked Songs",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          Icon(
            Icons.more_vert,
            size: 25,
            color: Colors.white,
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Center(
            child: Container(
              height: 40.h,
              width: 80.w,
              color: Colors.black,
              child: Image.asset("${providerT!.songinfo[providerT!.songindex].image}", ),
            ),
          ),
          SizedBox(height: 70),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "${providerT!.songinfo[providerT!.songindex].song}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.favorite_outline_sharp,
                      size: 25,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "${providerT!.songinfo[providerT!.songindex].singer}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
         PlayerBuilder.currentPosition(player:providerF!.assetsAudioPlayer , builder: (context, position) {
           return Column(
             children: [
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 1),
                 child: Slider(
                   value: position.inSeconds.toDouble(),
                   max: providerT!.songDuration.inSeconds.toDouble(),
                   onChanged: (value) {
                     position = Duration(seconds: value.toInt());
                     providerT!.assetsAudioPlayer.seek(position);
                   },
                   activeColor: Colors.white,
                   inactiveColor: Colors.grey.shade600,
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 24),
                 child: Row(
                   children: [
                     Text(
                       "$position",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 12,
                         letterSpacing: 1,
                       ),
                     ),
                     Spacer(),
                     Text(
                       "${providerT!.songDuration}",
                       style: TextStyle(
                         color: Colors.white,
                         fontSize: 12,
                         letterSpacing: 1,
                       ),
                     ),
                   ],
                 ),
               ),
             ],
           );
         },),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.shuffle,
                  size: 30,
                  color: Colors.white,
                ),
                InkWell(
                  onTap: () {
                    providerF!.preaudio();
                  },
                  child: Icon(
                    Icons.skip_previous,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                FloatingActionButton(
                    onPressed: () {
                      if (providerT!.assetsAudioPlayer.isPlaying.value) {
                        providerF!.pauseaudio();
                      } else {
                        providerF!.playaudio();
                      }
                    },
                    child: providerT!.isplay==false
                        ? Icon(Icons.pause, size: 30, color: Colors.black)
                        : Icon(Icons.play_arrow, size: 30, color: Colors.black),
                    backgroundColor: Colors.white),
                InkWell(
                  onTap: () {
                    providerF!.nextaudio();
                  },
                  child: Icon(
                    Icons.skip_next_sharp,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
                Icon(
                  Icons.repeat,
                  size: 30,
                  color: Colors.white,
                )
              ],
            ),
          ),
          SizedBox(height: 13),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Icon(
                  Icons.speaker_group_outlined,
                  size: 20,
                  color: Colors.white,
                ),
                Spacer(),
                Icon(
                  Icons.share,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 25),
                Icon(
                  Icons.format_line_spacing_sharp,
                  size: 20,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
