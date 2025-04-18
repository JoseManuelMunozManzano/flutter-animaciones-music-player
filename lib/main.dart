import 'package:flutter/material.dart';
import 'package:music_player/src/theme/theme.dart';
import 'package:music_player/src/pages/music_player_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: miTema,
      home: MusicPlayerPage(),
    );
  }
}
