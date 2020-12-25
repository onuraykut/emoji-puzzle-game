import 'package:flame/flame.dart';
import 'package:flame_emoji_game/tools/CustomCardShapePainter.dart';
import 'package:flame_emoji_game/tools/bgm.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_controller.dart';
import 'package:audioplayers/audioplayers.dart';

import 'level/emoji_levels.dart';
import 'levelsPage.dart';

class MyApp extends StatelessWidget {
  Size size;
  SharedPreferences pref;

  MyApp(this.size, this.pref);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Giris(size, pref),
    );
  }
}

class Giris extends StatefulWidget {
  Size size;
  SharedPreferences pref;

  Giris(this.size, this.pref);

  @override
  _GirisState createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  MyGame game;

  @override
  void initState() {
    BGM.play(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (game == null) {
      game =
          MyGame(widget.size, widget.pref, context, level: Levels.getLevel(1));
      PanGestureRecognizer panGestureRecognizer = PanGestureRecognizer();
      panGestureRecognizer.onEnd = game.onPanUpdate;
      Flame.util.addGestureRecognizer(panGestureRecognizer);
    }
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/ui/paper-background.jpg"),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          Container(
            height: widget.size.height * 0.5,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/logo_hallowen.png"),
                    fit: BoxFit.contain)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ButtonTheme(
                child: FlatButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LevelsPage(widget.size, widget.pref)),
                    ),
                    game.playGame(),
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.format_list_numbered_sharp,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Levels",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'JungleAdventurer'),
                      ),
                    ],
                  ),
                ),
              ),
              ButtonTheme(
                child: FlatButton(
                  onPressed: () => {
                    game.playGame(),
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => game.widget),
                    ),

                    // playPlayingBGM(),
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 6),
                        child: Icon(
                          Icons.play_circle_filled_outlined,
                          size: 30,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Start",
                        style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                            fontFamily: 'JungleAdventurer'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
