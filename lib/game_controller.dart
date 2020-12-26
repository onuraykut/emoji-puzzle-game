import 'package:giffy_dialog/giffy_dialog.dart';
import 'dart:async';
import 'dart:math' as math;
import 'package:emojis/emoji.dart';
import 'package:flame/flame.dart';
import 'package:flame_emoji_game/components/sound-button.dart';
import 'package:flame_emoji_game/tools/bgm.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flame/anchor.dart';
import 'package:flame_emoji_game/state.dart';
import 'package:flame/gestures.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutorial_coach_mark/content_target.dart';
import 'package:tutorial_coach_mark/target_focus.dart';
import 'package:tutorial_coach_mark/target_position.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'components/level_text.dart';
import 'components/menu-button.dart';
import 'components/music-button.dart';
import 'components/parallax.dart';
import 'level/emoji_levels.dart';
import 'tools/xy.dart';

class MyGame extends BaseGame with TapDetector {
  List<EmojiObject> enemies;
  bool isWin;
  BuildContext context;
  List<int> cizgiler;
  States state;
  Size size;
  int failIndex;
  int tapIndex;
  List<Timer> timer;
  Level level;
  ParallaxComponent parallaxComponent;
  MusicButton musicButton;
  SoundButton soundButton;
  MenuButton menuButton;
  List<TargetFocus> targets;
  SharedPreferences prefs;
  int splitLevel;
  bool isFirstClassic;
  bool isFirstTapGame;
  bool isFirstSplitGame;

  MyGame(this.size, this.prefs, BuildContext context, {this.level}) {
    final images = [
      ParallaxImage('1.png'),
    ];
    parallaxComponent = ParallaxComponent(images,
        baseSpeed: Offset.zero, layerDelta: Offset.zero);
    add(parallaxComponent);
    this.context = context;
    add(LevelText());
    add(musicButton = MusicButton(size));
    add(soundButton = SoundButton(size));
    add(menuButton = MenuButton());
    state = States.menu;
    enemies = List<EmojiObject>();
    timer = List<Timer>();
    cizgiler = new List<int>();
    targets = new List<TargetFocus>();
    // dialog();

    isFirstClassic = prefs.getBool('isFirstClassic') ?? true;
    isFirstTapGame = prefs.getBool('isFirstTapGame') ?? true;
    isFirstSplitGame = prefs.getBool('isFirstTapGame') ?? true;
    // createLevel(3,3);
  }

  setLevel(Level level) {
    this.level = level;
  }

  playGame() {
    /*  if (level.type == GameTypes.splitGame) {
      components.remove(parallaxComponent);
      final images = [
        ParallaxImage('3.jpg'),
      ];
      parallaxComponent = ParallaxComponent(images,
          baseSpeed: Offset.zero, layerDelta: Offset.zero);
      add(parallaxComponent);
    }*/

    cizgiler.clear();
    createLevel();
    splitLevel = 0;
    timer.forEach((element) {
      if (element.isActive) element.cancel();
    });
    timer.clear();

    if (isFirstClassic) {
      showTutorial();
    } else if (isFirstTapGame) {
      targets.clear();
      showTutorial();
    } else if (isFirstSplitGame) {
      targets.clear();
      showTutorial();
    } else {
      state = States.playing;
      parallaxComponent.baseSpeed = Offset(0, 35);
      if (level.type == GameTypes.classic)
        setTimerToShift();
      else if (level.type == GameTypes.tapGame) tapGameShift();
    }
  }

  setTimerToShift() {
    if (level.shiftMilisecond != null)
      for (int i = 1; i < level.sizeY; i++) {
        timer.add(Timer.periodic(Duration(milliseconds: level.shiftMilisecond),
                (timer) {
              var list = new List<int>.generate(
                  level.sizeX, (int index) => index + level.sizeX * i);
              list.shuffle();
              double x1 = enemies[list[0]].x;
              double x2 = enemies[list[1]].x;
              enemies[list[0]].x = x2;
              enemies[list[1]].x = x1;
            }));
      }
  }

  enemiesShuffle() {
    for (int i = 1; i < level.sizeY; i++) {
      var list = new List<int>.generate(
          level.sizeX, (int index) => index + level.sizeX * i);
      list.shuffle();
      double x1 = enemies[list[0]].x;
      double x2 = enemies[list[1]].x;
      enemies[list[0]].x = x2;
      enemies[list[1]].x = x1;
    }
  }

  enemiesShuffleSplit() {
    for (int i = 0; i < level.sizeY; i++) {
      var list = new List<int>.generate(
          level.sizeX, (int index) => index + 1 + level.sizeX * i);
      list.shuffle();
      double x1 = enemies[list[0]].x;
      double x2 = enemies[list[1]].x;
      enemies[list[0]].x = x2;
      enemies[list[1]].x = x1;
    }
  }

  tapGameShift() {
    List<XY> xy = List<XY>();
    for (int i = 0; i < enemies.length; i++) {
      xy.add(XY(enemies[i].x, enemies[i].y));
    }
    if (level.shiftMilisecond != null)
      timer.add(Timer.periodic(Duration(milliseconds: level.shiftMilisecond),
              (timer) {
            xy.shuffle();
            enemies.asMap().forEach((index, element) {
              element.isShow = false;
              element.x = xy[index].x;
              element.y = xy[index].y;
            });
            new Timer(new Duration(seconds: 2), () {
              enemies.asMap().forEach((index, element) {
                element.isShow = true;
              });
            });
          }));
  }

  @override
  void render(Canvas canvas) {
    if (parallaxComponent.loaded()) {
      parallaxComponent.render(canvas);
    }
    if (level.type == GameTypes.classic) {
      if (cizgiler != null) {
        Paint paintLine = Paint();
        paintLine.strokeWidth = 10;
        paintLine.color = Colors.green;
        canvas.drawCircle(
            enemies[level.emojiAndAnswer.emojiAnswer[0]].emojiRect.center,
            level.emojiSize,
            paintLine);
        for (int i = 0; i < cizgiler.length; i++) {
          if (i != cizgiler.length - 1) {
            if (cizgiler[i + 1] == failIndex)
              paintLine.color = Colors.red;
            else
              canvas.drawCircle(enemies[cizgiler[i + 1]].emojiRect.center,
                  level.emojiSize, paintLine);
            canvas.drawLine(enemies[cizgiler[i]].emojiRect.center,
                enemies[cizgiler[i + 1]].emojiRect.center, paintLine);
          }
        }
      }
      if (failIndex != null) {
        canvas.drawCircle(enemies[failIndex].emojiRect.center, level.emojiSize,
            Paint()..color = Colors.red);
      }
    } else if (level.type == GameTypes.tapGame) {
      Paint paintLine = Paint();
      paintLine.strokeWidth = 10;
      if (tapIndex != null) {
        paintLine.color = Colors.green;
        canvas.drawCircle(
            enemies[tapIndex].emojiRect.center, level.emojiSize, paintLine);
      }
      if (failIndex != null) {
        paintLine.color = Colors.red;
        canvas.drawCircle(
            enemies[failIndex].emojiRect.center, level.emojiSize, paintLine);
      }
    }
    super.render(canvas);
  }

  @override
  void update(double t) {
    if (parallaxComponent.loaded()) {
      parallaxComponent.update(t);
    }
    super.update(t);
  }

  @override
  void onTapDown(TapDownDetails details) {
    debugPrint('gameType: ' + level.type.toString());
    if (musicButton.rect.contains(details.globalPosition)) {
      if (musicButton.isEnabled) {
        musicButton.isEnabled = false;
        BGM.pause();
      } else {
        musicButton.isEnabled = true;
        BGM.resume();
      }
    } else if (soundButton.rect.contains(details.globalPosition)) {
      if (soundButton.isEnabled) {
        soundButton.isEnabled = false;
      } else {
        soundButton.isEnabled = true;
      }
    } else if (menuButton.rect.contains(details.globalPosition)) {
      Navigator.of(context).pop();
    } else {
      if (state == States.menu) {
        if (isWin)
          successLevel();
        else
          gameOver();
      } else if (state == States.playing) {
        if (level.type == GameTypes.classic) {
          enemies.asMap().forEach((index, element) {
            if (element.emojiRect.contains(details.globalPosition)) {
              if (index == level.emojiAndAnswer.emojiAnswer[cizgiler.length]) {
                cizgiler.add(index);
                if (cizgiler.length == level.emojiAndAnswer.emojiAnswer.length)
                  successLevel();
                else if (soundButton.isEnabled)
                  Flame.audio.play('bgm/Ding.mp3');
              } else {
                debugPrint(index.toString() +
                    '---' +
                    level.emojiAndAnswer.emojiAnswer[cizgiler.length]
                        .toString() +
                    '--+-' +
                    cizgiler.toString());
                failIndex = index;
                cizgiler.add(index);
                gameOver();
              }
            }
          });
        } else if (level.type == GameTypes.tapGame) {
          enemies.asMap().forEach((index, element) {
            if (element.emojiRect.contains(details.globalPosition)) {
              if (index == level.emojiAndAnswer.emojiAnswer[0]) {
                tapIndex = index;
                successLevel();
              } else {
                failIndex = index;
                gameOver();
              }
            }
          });
        } else if (level.type == GameTypes.splitGame) {}
      }
    }

    super.onTapDown(details);
  }

  createLevel() {
    components.forEach((c) {
      if (c is PositionComponent) markToRemove(c);
    });
    enemies.clear();
    tapIndex = null;
    isWin = false;

    debugPrint('cizgiler_size: ' + cizgiler.length.toString());
    if (level.type == GameTypes.classic || level.type == GameTypes.tapGame)
      for (int i = 0; i < level.sizeY; i++) {
        for (int y = 0; y < level.sizeX; y++) {
          EmojiObject square = EmojiObject(index: enemies.length)
            ..x = this.size.width / (1.4 * level.sizeX) * (y + 1)
            ..y = this.size.height / 8 * (i + 1);
          enemies.add(square);
          add(square);
          // offset[i][y] = new Offset(size.width / 4 * (y+1), size.height / 8 * (i+1));
        }
      }
    else if (level.type == GameTypes.splitGame) {
      EmojiObject square = EmojiObject(index: enemies.length)
        ..x = this.size.width / (1.4 * level.sizeX)
        ..y = this.size.height * 0.05;
      enemies.add(square);
      add(square);
      for (int y = 0; y < level.sizeY; y++) {
        for (int i = 0; i < level.sizeX; i++) {
          EmojiObject square2 = EmojiObject(index: enemies.length)
            ..x = this.size.width / (1.4 * level.sizeX) * (i + 1)
            ..y = this.size.height / 4 + (this.size.height / 5) * y;
          enemies.add(square2);
          add(square2);
        }
      }
    }
    if (level.type == GameTypes.classic) {
      cizgiler.add(level.emojiAndAnswer.emojiAnswer[0]);
      if (failIndex != null) enemiesShuffle();
    } else if (level.type == GameTypes.splitGame) {
      if (failIndex != null) enemiesShuffleSplit();
    }
    failIndex = null;
  }

  void createTarget(GameTypes gameType) {
    switch (gameType) {
      case GameTypes.classic:
        targets.add(
          TargetFocus(
              identify: "Target 1",
              targetPosition: new TargetPosition(
                  new Size(level.emojiSize, level.emojiSize),
                  new Offset(
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].x -
                          level.emojiSize / 2,
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].y -
                          level.emojiSize / 2)),
              contents: [
                ContentTarget(
                    align: AlignContent.bottom,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Nasıl oynanır?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 20.0),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Seçili gelen emoji ile bir alt satırdaki ona benzer emojiyi seçmelisiniz."
                              "Eğer yanlış seçerseniz ya da emojiler en alta değerse yanarsınız.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        );
        targets.add(
          TargetFocus(
              identify: "Target 2",
              targetPosition: new TargetPosition(
                  new Size(level.emojiSize, level.emojiSize),
                  new Offset(
                      enemies[level.emojiAndAnswer.emojiAnswer[1]].x -
                          level.emojiSize / 2,
                      enemies[level.emojiAndAnswer.emojiAnswer[1]].y -
                          level.emojiSize / 2)),
              contents: [
                ContentTarget(
                    align: AlignContent.bottom,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Üst satırdaki emoji ile en alakalı emoji bu,o yüzden buna basmalısınız.\nHadi başlayalım",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        );
        break;
      case GameTypes.tapGame:
        targets.add(
          TargetFocus(
              identify: "Target 1",
              targetPosition: new TargetPosition(
                  new Size(level.emojiSize, level.emojiSize),
                  new Offset(
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].x -
                          level.emojiSize / 2,
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].y -
                          level.emojiSize / 2)),
              contents: [
                ContentTarget(
                    align: AlignContent.bottom,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Bu bölümde ise farklı olan emojiyi bulmalısınız\nAralarında farklı kategoride olan emoji bu,o yüzden bunu seçmelisiniz",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        );
        break;
      case GameTypes.splitGame:
        targets.add(
          TargetFocus(
              identify: "Target 1",
              targetPosition: new TargetPosition(
                  new Size(level.emojiSize, level.emojiSize),
                  new Offset(enemies[0].x - level.emojiSize / 2,
                      enemies[0].y - level.emojiSize / 2)),
              contents: [
                ContentTarget(
                    align: AlignContent.bottom,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Bu bölümde aynı kategoride olan emojiye değerek en alta kadar ilerlemelisiniz.\nSol ve sağa gitmek için parmağınızı kaydırın.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        );
        targets.add(
          TargetFocus(
              identify: "Target 2",
              targetPosition: new TargetPosition(
                  new Size(level.emojiSize, level.emojiSize),
                  new Offset(
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].x -
                          level.emojiSize / 2,
                      enemies[level.emojiAndAnswer.emojiAnswer[0]].y -
                          level.emojiSize / 2)),
              contents: [
                ContentTarget(
                    align: AlignContent.bottom,
                    child: Container(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Text(
                              "Yukarıdaki emoji ile aynı kategoride olan emoji bu, o yüzden bunun üzerinden geçmelisiniz.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
        );
        break;
    }
  }

  void showTutorial() {
    createTarget(level.type);
    TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.blueAccent,
      opacityShadow: 0.5,
      hideSkip: true,
      onFinish: () {
        state = States.playing;
        parallaxComponent.baseSpeed = Offset(0, 35);
        switch (level.type) {
          case GameTypes.classic:
            setTimerToShift();
            isFirstClassic = false;
            prefs.setBool('isFirstClassic', false);
            break;
          case GameTypes.tapGame:
            isFirstTapGame = false;
            prefs.setBool('isFirstTapGame', false);
            break;
          case GameTypes.splitGame:
            isFirstSplitGame = false;
            prefs.setBool('isFirstSplitGame', false);
            break;
        }
      },
      onClickTarget: (target) {
        print(target);
      },
      onClickSkip: () {},
    )..show();
  }

  dialog() {
    /* gameOverDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      aligment: Alignment.bottomCenter,
      isDense: true,
      title: 'Game Over',
      desc: '',
      btnOkText: 'Play Again',
      btnCancelText: 'Menu',
      useRootNavigator: false,
      btnCancelOnPress: () {
        // Navigator.popUntil(context, ModalRoute.withName('/giris'));
        Navigator.of(context, rootNavigator: false).pop();
      },
      btnOkOnPress: () {
        gameOverDialog = null;
        dialog();
        playGame();
        // gameOverDialog.dissmiss();
      },
    );
    successDialog = AwesomeDialog(
      context: context,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      aligment: Alignment.bottomCenter,
      title: 'SUCCESS!',
      desc: '',
      btnOkText: 'Next Level',
      btnCancelText: 'Menu',
      btnCancelOnPress: () {
        Navigator.of(context, rootNavigator: false)
            .pop(); // Navigator.popUntil(context, ModalRoute.withName('/giris'));
      },
      btnOkOnPress: () {
        successDialog = null;
        dialog();
        setLevel(Levels.getLevel(level.levelIndex + 1));
        playGame();
        // Navigator.of(context).pop();
      },
    );*/
  }

  showGameOverDialog() {
    showDialog(
        context: context,
        builder: (contex) => AssetGiffyDialog(
              image: Image.asset(
                'assets/images/giphy.gif',
                fit: BoxFit.cover,
              ),
              title: Text(
                'Game Over!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.red,
                    fontFamily: 'JungleAdventurer'),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              /*description: Text(
                'This is a men wearing jackets dialog box. This library helps you easily create fancy giffy dialog.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),*/
              buttonOkText: Text(
                'Again',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'JungleAdventurer'),
              ),
              buttonCancelText: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'JungleAdventurer'),
              ),
              onOkButtonPressed: () {
                Navigator.of(contex).pop();
                playGame();
              },
              onCancelButtonPressed: () {
                Navigator.of(context, rootNavigator: false).pop();
              },
            ));
  }

  showSuccesDialog() {
    showDialog(
        context: context,
        builder: (contex) => AssetGiffyDialog(
              image: Image.asset(
                'assets/images/level-complete.gif',
                fit: BoxFit.contain,
              ),
              title: Text(
                'SUCCESS!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.green,
                    fontFamily: 'JungleAdventurer'),
              ),
              entryAnimation: EntryAnimation.BOTTOM,
              /*description: Text(
                'This is a men wearing jackets dialog box. This library helps you easily create fancy giffy dialog.',
                textAlign: TextAlign.center,
                style: TextStyle(),
              ),*/
              buttonOkText: Text(
                'Next Level',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'JungleAdventurer'),
              ),
              buttonCancelText: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: 'JungleAdventurer'),
              ),
              onCancelButtonPressed: () {
                Navigator.of(context, rootNavigator: false).pop();
              },
              onOkButtonPressed: () {
                Navigator.of(contex).pop();
                setLevel(Levels.getLevel(level.levelIndex + 1));
                playGame();
              },
            ));
  }

  gameOver() {
    state = States.menu;
    if (soundButton.isEnabled) Flame.audio.play('bgm/lose.wav');
    // gameOverDialog..show();
    showGameOverDialog();
    timer.forEach((element) => element.cancel());
    parallaxComponent.baseSpeed = Offset.zero;
  }

  successLevel() {
    state = States.menu;
    isWin = true;
    if (soundButton.isEnabled) Flame.audio.play('bgm/win.wav');
    showSuccesDialog();
    timer.forEach((element) => element.cancel());
    parallaxComponent.baseSpeed = Offset.zero;
  }

  void onPanUpdate(DragEndDetails d) {
    if (d.velocity.pixelsPerSecond.dx.abs() >
        d.velocity.pixelsPerSecond.dy.abs() &&
        state == States.playing) {
      // X Axis
      if (d.velocity.pixelsPerSecond.dx < 0) {
        //left
        if (enemies.first.x > size.width / (1.4 * level.sizeX) - 1)
          enemies.first.x -= size.width / (1.4 * level.sizeX);
      } else {
        //right
        if (enemies.first.x < size.width - (1.4 * level.sizeX) + 1)
          enemies.first.x += size.width / (1.4 * level.sizeX);
      }
    }
  }
}

class EmojiObject extends PositionComponent with HasGameRef<MyGame> {
  var rand = new math.Random();
  int angleRotate = 1;
  Size size;
  Rect emojiRect;
  int index;
  bool isShow = true;

  EmojiObject({this.index}) {
    angleRotate = rand.nextInt(2);
    if (angleRotate == 0) angleRotate = -1;
  }

  @override
  void render(Canvas c) {
    prepareCanvas(c);
    if (isShow) draw_emoji(c);
  }

  draw_emoji(Canvas c) {
    TextSpan span = new TextSpan(
        style: TextStyle(fontSize: width, fontFamily: 'NotoColorEmoji'),
        text: gameRef.level.emojiAndAnswer.emoji[index].toString());
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl);
    tp.layout();
    // tp.layout(minWidth: 0, maxWidth: 0);
    Offset drawPosition = Offset.fromDirection(0);
    tp.paint(c, drawPosition);
  }

  @override
  void update(double t) {
    if (gameRef.state == States.playing) {
      if (gameRef.level.type == GameTypes.classic) {
        if (index >= (gameRef.level.sizeX * 2))
          y += gameRef.level.downSPEED * t * 2;
        else if (index >= gameRef.level.sizeX) y += gameRef.level.downSPEED * t;

        if (gameRef.size != null && y > gameRef.size.height - width / 2) {
          gameRef.state = States.menu;
          gameRef.gameOver();
        }
        angle += gameRef.level.angleSPEED * t * angleRotate;
        angle %= 2 * math.pi;
        // }
      } else if (gameRef.level.type == GameTypes.splitGame) {
        if (index == 0) y += gameRef.level.downSPEED * t;
        if (gameRef.size != null && y > gameRef.size.height - width / 2) {
          gameRef.state = States.menu;
          gameRef.gameOver();
          gameRef.failIndex = 0;
          gameRef.enemies.forEach((element) {
            element.isShow = true;
          });
        }
        for (int i = 1; i < gameRef.enemies.length; i++) {
          if (gameRef.enemies[i].emojiRect != null) if (gameRef
              .enemies.first.emojiRect
              .overlaps(gameRef.enemies[i].emojiRect)) {
            if (i !=
                gameRef.level.emojiAndAnswer.emojiAnswer[gameRef.splitLevel]) {
              gameRef.gameOver();
              gameRef.failIndex = i;
              gameRef.enemies.forEach((element) {
                element.isShow = true;
              });
            } else {
              Flame.audio.play('bgm/Ding.mp3');
              gameRef.enemies[i].emojiRect =
              new Rect.fromPoints(Offset.zero, Offset.zero);
              gameRef.enemies[i].isShow = false;
              gameRef.splitLevel++;
              if (gameRef.level.emojiAndAnswer.emojiAnswer.length ==
                  gameRef.splitLevel) gameRef.successLevel();
            }
          }
        }
      }
    }

    /* switch(gameRef.level.type) {

      case GameTypes.classic:
        emojiRect = new Rect.fromLTWH(
            x - gameRef.level.emojiSize,
            y - gameRef.level.emojiSize,
            gameRef.level.emojiSize*2,
            gameRef.level.emojiSize*2);
        break;
      case GameTypes.tapGame:
        emojiRect = new Rect.fromLTWH(
            x - gameRef.level.emojiSize,
            y - gameRef.level.emojiSize,
            gameRef.level.emojiSize*2,
            gameRef.level.emojiSize*2);
        break;
      case GameTypes.splitGame:
        emojiRect = new Rect.fromLTWH(
            x - gameRef.level.emojiSize/2,
            y - gameRef.level.emojiSize/2,
            gameRef.level.emojiSize,
            gameRef.level.emojiSize);
        break;
    }*/

    if (isShow) {
      if (gameRef.level.type == GameTypes.splitGame)
        emojiRect = new Rect.fromLTWH(
            x - gameRef.level.emojiSize / 2,
            y - gameRef.level.emojiSize / 2,
            gameRef.level.emojiSize,
            gameRef.level.emojiSize);
      else
        emojiRect = new Rect.fromLTWH(
            x - gameRef.level.emojiSize,
            y - gameRef.level.emojiSize,
            gameRef.level.emojiSize * 2,
            gameRef.level.emojiSize * 2);
    }
    super.update(t);
  }

  @override
  void onMount() {
    width = height = gameRef.level.emojiSize;
    anchor = Anchor.center;
  }
}
