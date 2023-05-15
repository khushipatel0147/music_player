import 'package:flutter/material.dart';
import 'package:music_player/musicPlayer/provider/musicProvider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MusicProvider? musicProviderFalse;
  MusicProvider? musicProviderTrue;

  @override
  Widget build(BuildContext context) {
    musicProviderFalse = Provider.of<MusicProvider>(context, listen: false);
    musicProviderTrue = Provider.of<MusicProvider>(context, listen: true);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
          size: 25,
        ),
        title: Text("Music Player",
            style:
                TextStyle(color: Colors.white, letterSpacing: 1, fontSize: 18)),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) => playList(index),
        itemCount: musicProviderFalse!.songinfo.length,
      ),
    ));
  }

  Widget playList(int index) {
    return InkWell(
      onTap: () {
        musicProviderFalse!.songchange(index);
        musicProviderFalse!.initPlayer();
        Navigator.pushNamed(context, 'play', arguments: index);
      },
      child: Row(
        children: [
          SizedBox(width: 2),
          Image.asset(
            "${musicProviderFalse!.songinfo[index].image}",
            height: 70,
            width: 70,
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${musicProviderFalse!.songinfo[index].song}",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, fontSize: 15),
              ),
              SizedBox(height: 2),
              Text(
                "${musicProviderFalse!.songinfo[index].singer}",
                style: TextStyle(
                    color: Colors.white, letterSpacing: 1, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
