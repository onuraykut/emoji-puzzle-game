import 'package:flame_emoji_game/game_controller.dart';
import 'package:flame_emoji_game/tools/CustomCardShapePainter.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'level/emoji_levels.dart';

class LevelsPage extends StatefulWidget {
  Size size;
  SharedPreferences pref;

  LevelsPage(this.size, this.pref);

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/ui/paper-background.jpg"),
                fit: BoxFit.fill)),
        child: Column(
          children: <Widget>[
            // Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: ButtonTheme(
                  child: FlatButton(
                    color: Colors.white54,
                    onPressed: () => {
                      Navigator.of(context).pop(),
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      // Replace with a Row for horizontal icon + text
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 6),
                          child: Icon(
                            Icons.backspace_rounded,
                            size: 15,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "Menu",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'JungleAdventurer'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "Select Level",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontFamily: 'JungleAdventurer'),
            ),
            Expanded(
              flex: 3,
              child: GridView.builder(
                  shrinkWrap: true,
                  primary: true,
                  itemCount: Levels.sayac.index,
                  padding: EdgeInsets.all(25),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 30,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return levelButton(index);
                  }),
            ),

            // Spacer(),
          ],
        ),
      ),
    );
  }

  Widget levelButton(int index) {
    return InkWell(
      onTap: () {
        if ((index + 1) <= Levels.sayac.index) {
          MyGame myGame = MyGame(widget.size, widget.pref, context);
          myGame.setLevel(Levels.getLevel(index + 1));
          myGame.playGame();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => myGame.widget),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              gradient: LinearGradient(
                  colors: [Color(0xffE05600), Color(0xffD94700)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                  //offset: Offset(0, 6),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: CustomPaint(
                size: Size(75, 125),
                painter: CustomCardShapePainter(
                    12, Color(0xffE05600), Color(0xffD94700)),
              ),
            ),
          ),
          Center(
            child: (index + 1) <= Levels.sayac.index
                ? Text(
                    (index + 1).toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  )
                : Icon(
                    Icons.lock,
                    color: Colors.white,
                    size: 40,
                  ),
          ),
        ],
      ),
    );
  }
}
