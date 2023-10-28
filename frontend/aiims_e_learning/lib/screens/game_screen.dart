import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audio_cache.dart';
import 'package:google_fonts/google_fonts.dart';

class ColorGame extends StatefulWidget {
  static String id = 'game_screen';
  ColorGame({Key key}) : super(key: key);

  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  final Map<String, bool> score = {};
  Map choices = {};

  @override
  void initState() {
    setchoice();
    super.initState();
  }

  List blackbox_waste = [
    'images/bottle.png',
    'images/paper.png',
    'images/papercup.png',
    'images/black_1.png',
    'images/black_2.png',
    'images/black_3.png',
    'images/black_4.png',
    'images/black_5.png',
  ];
  List redbox_waste = [
    'images/red_1.png',
    'images/red_2.png',
    'images/red_3.png',
    'images/red_4.png',
    'images/red_5.png',
    'images/red_6.png',
    'images/red_7.png',
  ];
  List yellowbox_waste = [
    'images/yellow_1.png',
    'images/yellow_2.png',
    'images/yellow_3.png',
    'images/yellow_4.png',
    'images/yellow_5.png',
    'images/yellow_6.png',
  ];
  List bluebox_waste = [
    'images/blue_1.png',
    'images/blue_2.png',
    'images/blue_3.png',
  ];
  List greenbox_waste = [
    'images/apple.png',
    'images/banana.png',
    'images/green_1.png',
    'images/green_2.png',
  ];
  List whitebox_waste = [
    'images/white_1.png',
    'images/white_2.png',
    'images/white_3.png',
    'images/white_4.png',
  ];

  String rnd(List a) {
    final _random = new Random();
    int r = 0 + _random.nextInt(a.length - 0);
    return a[r];
  }

  void setchoice() {
    setState(() {
      choices = {
        rnd(blackbox_waste): 'assets/images/flies/blackbin_copy.png',
        rnd(redbox_waste): 'assets/images/flies/redbin_copy.png',
        rnd(yellowbox_waste): 'assets/images/flies/yellowbin_copy.png',
        rnd(bluebox_waste): 'assets/images/flies/bluebin_copy.png',
        rnd(greenbox_waste): 'assets/images/flies/greenbin_copy.png',
        rnd(whitebox_waste): 'assets/images/flies/whitebin_copy.png'
      };
    });
  }

  int seed = 0;
  int feed = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Score ${score.length} / 6'),
          backgroundColor: Colors.blue),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            setchoice();
            seed++;
            feed++;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((emoji) {
                return Draggable<String>(
                  data: emoji,
                  child: Emoji(
                      emoji: score[emoji] == true ? 'images/tick.png' : emoji),
                  feedback: Emoji(emoji: emoji),
                  childWhenDragging: Emoji(emoji: 'images/garbage.png'),
                );
              }).toList()
                ..shuffle(
                  Random(feed),
                ),
            ),
            Spacer(),
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: choices.keys
                    .map((emoji) => _buildDragTarget(emoji))
                    .toList()
                      ..shuffle(
                        Random(seed),
                      ))
          ],
        ),
      ),
    );
  }

  Widget _buildDragTarget(emoji) {
    return Material(
      color: Colors.transparent,
      elevation: 100,
      shadowColor: Colors.blue,
      child: DragTarget<String>(
        builder: (BuildContext context, List<String> incoming, List rejected) {
          if (score[emoji] == true) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 0, bottom: 0),
              child: Container(
                color: Colors.blue,
                child: Text(
                  'Correct!',
                  style: GoogleFonts.portLligatSans(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                alignment: Alignment.center,
                height: 80,
                width: 150,
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, right: 16.0, top: 0, bottom: 0),
              child: Container(
                  child: Image.asset(
                    choices[emoji],
                    fit: BoxFit.contain,
                  ),
                  height: 80,
                  width: 80),
            );
          }
        },
        onWillAccept: (data) => data == emoji,
        onAccept: (data) {
          setState(() {
            score[emoji] = true;
            plyr.play('success.mp3');
          });
        },
        onLeave: (data) {},
      ),
    );
  }
}

class Emoji extends StatelessWidget {
  Emoji({Key key, this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 100,
      shadowColor: Colors.blue,
      child: Container(
          alignment: Alignment.center,
          height: 100,
          padding: EdgeInsets.all(10),
          child: Image.asset(
            emoji,
            fit: BoxFit.cover,
          )),
    );
  }
}

AudioCache plyr = AudioCache();
