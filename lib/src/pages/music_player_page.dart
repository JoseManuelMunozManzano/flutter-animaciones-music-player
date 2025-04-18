import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:animate_do/animate_do.dart';

import 'package:provider/provider.dart';
import 'package:music_player/src/models/audioplayer_model.dart';

import 'package:music_player/src/widgets/custom_appbar.dart';

import 'package:music_player/src/helpers/helpers.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

   @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
          children: [

            Background(),

            Column(
              children: [
                
                CustomAppbar(),
            
                ImagenDiscoDuracion(),
            
                TituloPlay(),
            
                Expanded(
                  child: Lyrics()
                ),
              ],
            ),
          ],
        )
      );
    }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final screenSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: screenSize.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ]
        )
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final lyrics = getLyrics();

    return Container(
      child: ListWheelScrollView(
        physics: BouncingScrollPhysics(),
        itemExtent: 42,
        diameterRatio: 1.5,
        children: lyrics.map(
          (linea) => Text(linea, style: TextStyle(fontSize: 20, color: Colors.white.withValues(alpha: 0.6)))
        ).toList()
      ),
    );
  }
}

class TituloPlay extends StatefulWidget {
  const TituloPlay({
    super.key,
  });

  @override
  State<TituloPlay> createState() => _TituloPlayState();
}

class _TituloPlayState extends State<TituloPlay> with SingleTickerProviderStateMixin {

  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController playAnimation;
  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    playAnimation = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  void dispose() {
    playAnimation.dispose();
    super.dispose();
  }

  // Llamamos a este método al dar play la primera vez.
  void open() {
    final audioPlayerModel = Provider.of<AudioplayerModel>(context, listen: false);

    assetAudioPlayer.open(
      Audio('assets/Breaking-Benjamin-Far-Away.mp3'),
      autoStart: true,
      showNotification: true
    );

    // Es un listener, un stream que va a estar emitiendo cada vez que cambie
    // el segundo actual.
    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayerModel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayerModel.songDuration = playingAudio?.audio.duration ?? Duration(seconds: 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 50),
      margin: EdgeInsets.only(top: 40),
      child: Row(
        children: [
          Column(
            children: [
              Text('Far Away', style: TextStyle(fontSize: 30, color: Colors.white.withValues(alpha: 0.8))),
              Text('-Breaking Benjamin-', style: TextStyle(fontSize: 15, color: Colors.white.withValues(alpha: 0.5))),
            ],
          ),

          Spacer(),
          
          FloatingActionButton(
            elevation: 0,
            highlightElevation: 0,
            shape: CircleBorder(),
            backgroundColor: Color(0xffF8CB51),
            onPressed: () {

              final audioPlayerModel = Provider.of<AudioplayerModel>(context, listen: false);

              if (isPlaying) {
                playAnimation.reverse();
                isPlaying = false;
                audioPlayerModel.controller.stop();
              } else {
                playAnimation.forward();
                isPlaying = true;
                audioPlayerModel.controller.repeat();
              }

              if (firstTime) {
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
            },
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause,
              color: Colors.black,
              progress: playAnimation,
            )
          )
        ],
      ),
    );
  }
}

class ImagenDiscoDuracion extends StatelessWidget {
  const ImagenDiscoDuracion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      margin: EdgeInsets.only(top: 70),
      child: Row(
        children: [

          ImagenDisco(),
          SizedBox(width: 40),

          BarraProgreso(),
          SizedBox(width: 20),
        ],
      ),
    );
  }
}

class BarraProgreso extends StatelessWidget {
  const BarraProgreso({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final estilo = TextStyle(color: Colors.white.withValues(alpha: 0.4));
    final audioPlayerModel = Provider.of<AudioplayerModel>(context);
    final porcentaje = audioPlayerModel.porcentaje;

    return Container(
      child: Column(
        children: [

          Text(audioPlayerModel.songTotalDuration, style: estilo),
          SizedBox(height: 10),

          Stack(
            children: [

              Container(
                width: 3,
                height: 230,
                color: Colors.white.withValues(alpha: 0.1),
              ),

              Positioned(
                bottom: 0,
                child: Container(
                  width: 3,
                  height: 230 * porcentaje,
                  color: Colors.white.withValues(alpha: 0.8),
                ),
              ),

            ],
          ),

          SizedBox(height: 10),
          Text(audioPlayerModel.currentSecond, style: estilo),
        ],
      ),
    );
  }
}

class ImagenDisco extends StatelessWidget {
  const ImagenDisco({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final audioPlayerModel = Provider.of<AudioplayerModel>(context);

    return Container(
      padding: EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(200),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24),
          ]
        )
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,

          children: [

            SpinPerfect(
              duration: Duration(seconds: 10),
              infinite: true,
              // Con manualTrigger y el controller, el play a la animación se hace usando el provider,
              // en la clase _TituloPlayState
              manualTrigger: true,
              controller: (animationController) => audioPlayerModel.controller = animationController,
              child: Image(image: AssetImage('assets/aurora.jpg'))
            ),

            // Para hacer el punto del centro de la imagen.
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            // El otro punto más pequeño dentro del anterior punto.
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(100),
              ),
            )
          ],
        )
      ),
    );
  }
}
