import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/musicPlayer/provider/musicProvider.dart';
import 'package:music_player/musicPlayer/view/homeScreen.dart';
import 'package:music_player/musicPlayer/view/playScreen.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

void main()
{
  runApp(Sizer(
    builder: (context, orientation, deviceType) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MusicProvider(),)
        ],

        child: MaterialApp(debugShowCheckedModeBanner: false,
          routes: {
            '/':(context) => HomeScreen(),
            'play':(context) => PlayScreen(),
          },),
      );
    },
  ));
}