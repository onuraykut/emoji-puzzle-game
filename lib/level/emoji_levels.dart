import 'dart:math';

import 'package:emojis/emoji.dart';
import 'package:flutter/material.dart';

import '../state.dart';

class Level {
  int levelIndex;
  int sizeX;
  int sizeY;
  EmojiAndAnswer emojiAndAnswer;
  double downSPEED;
  double angleSPEED;
  double emojiSize;
  int shiftMilisecond;
  GameTypes type;

  Level({
    this.levelIndex,
    this.sizeX,
    this.sizeY,
    this.emojiAndAnswer,
    this.downSPEED,
    this.angleSPEED,
    this.emojiSize,
    this.shiftMilisecond,
    this.type,
  });
}

class Levels {
  static List allEmoji = Emoji.all();
  static Random rand = Random();
  static Sayac sayac = new Sayac();
  static final level = [
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 2,
      sizeY: 2,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(4), 2, 2),
      downSPEED: 20,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      //t1
      levelIndex: sayac.getIndex(),
      sizeX: 2,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(6), 2, 3),
      downSPEED: 20,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(9), 3, 3),
      downSPEED: 50,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      //t2
      levelIndex: sayac.getIndex(),
      sizeX: 2,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(6), 2, 3),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      //t3
      levelIndex: sayac.getIndex(),
      sizeX: 2,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(6), 2, 3),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(9), 3, 3),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 4000,
      type: GameTypes.tapGame,
    ),
    Level(
      //t1
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      //t1s1
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 50,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),

    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2000,
      type: GameTypes.tapGame,
    ),
    //
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 50,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),

    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 3,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(9), 3, 3),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2500,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    //
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 60,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 1500,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(12), 3, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2500,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(16), 4, 4),
      downSPEED: 70,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 4000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 40,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 3000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 3,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(15), 3, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2500,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 50,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2500,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 50,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 4,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 4),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2500,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 60,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 5),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(16), 4, 5),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(20), 4, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(20), 4, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 70,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 4,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(20), 4, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2500,
    ),
    //5x5
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 20,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 40,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 30,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 40,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 4000,
    ),
    Level(
      //t4
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomTapGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 0,
      angleSPEED: 0,
      emojiSize: 32.0,
      shiftMilisecond: 2000,
      type: GameTypes.tapGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 20,
      angleSPEED: 3,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 3000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 4, 4),
      downSPEED: 30,
      angleSPEED: 3,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 2000,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomSplitGame(randomSubListWithSize(25), 5, 5),
      downSPEED: 60,
      angleSPEED: 1,
      emojiSize: 32.0,
      type: GameTypes.splitGame,
    ),
    Level(
      levelIndex: sayac.getIndex(),
      sizeX: 5,
      sizeY: 5,
      emojiAndAnswer: randomEmoji(randomSubListWithSize(25), 5, 5),
      downSPEED: 50,
      angleSPEED: 2,
      emojiSize: 32.0,
      type: GameTypes.classic,
      shiftMilisecond: 1500,
    ),
  ];

  static randomEmoji(EmojiSubgroup emojiGroup, int x, int y) {
    List cevaplarIndex = List<int>();
    List<Emoji> emojis = List<Emoji>();
    List emojiList = Emoji.bySubgroup(emojiGroup).toList();
    emojiList.shuffle();
    // debugPrint('subgroup:' + emojiGroup.toString());
    List randlist =
        new List<int>.generate(y, (int index) => index % x); // [0, 1, 4]
    randlist.shuffle();
    List randSecilenler = new List<int>();
    for (int i = 0; i < y; i++) {
      for (int z = 0; z < x; z++) {
        if (z == randlist[i]) {
          int sayi = rand.nextInt(emojiList.length - 1) + 1;
          randSecilenler.add(sayi);
          emojis.add(emojiList[sayi]);
          cevaplarIndex.add(z + (x * i));
          // debugPrint('true');
        } else {
          // debugPrint('else');
          int rnd = new Random().nextInt(allEmoji.length - 1);
          emojis.add(allEmoji[rnd]);
        }
      }
    }

    debugPrint(cevaplarIndex.toString());
    // debugPrint(emojis.toString());
    return new EmojiAndAnswer(emoji: emojis, emojiAnswer: cevaplarIndex);
  }

  static randomSplitGame(EmojiSubgroup emojiGroup, int x, int y) {
    List cevaplarIndex = List<int>();
    List<Emoji> emojis = List<Emoji>();
    List emojiList = Emoji.bySubgroup(emojiGroup).toList();
    emojiList.shuffle();
    // debugPrint('subgroup:' + emojiGroup.toString());
    List randlist =
        new List<int>.generate(y, (int index) => index % x); // [0, 1, 4]
    randlist.shuffle();
    // debugPrint('randList:' + randlist.toString());
    emojis.add(emojiList[0]);
    List randSecilenler = new List<int>();
    for (int i = 0; i < y; i++) {
      for (int z = 0; z < x; z++) {
        if (z == randlist[i]) {
          int sayi = rand.nextInt(emojiList.length - 1) + 1;
          randSecilenler.add(sayi);
          emojis.add(emojiList[sayi]);
          cevaplarIndex.add(z + (x * i) + 1);
        } else {
          int rnd = new Random().nextInt(allEmoji.length - 1);
          emojis.add(allEmoji[rnd]);
        }
      }
    }

    debugPrint(cevaplarIndex.toString());
    // debugPrint(emojis.toString());
    return new EmojiAndAnswer(emoji: emojis, emojiAnswer: cevaplarIndex);
  }

  static randomTapGame(EmojiSubgroup emojiGroup, int x, int y) {
    List<Emoji> emojis = List<Emoji>();
    List cevaplarIndex = List<int>();
    List emojiList = Emoji.bySubgroup(emojiGroup).toList();
    emojiList.shuffle();
    List emojiSubs = emojiList.take(x * y - 1).toList();

    int randNumber = rand.nextInt(x * y);
    cevaplarIndex.add(randNumber);
    int emojiSubCount = -1;
    for (int i = 0; i < x * y; i++) {
      if (i == randNumber) {
        emojis.add(allEmoji[rand.nextInt(allEmoji.length - 1)]);
      } else
        emojis.add(emojiSubs[++emojiSubCount]);
    }
    // debugPrint('cvp: ' + cevaplarIndex.toString() + '---' + emojis.toString());
    return new EmojiAndAnswer(emoji: emojis, emojiAnswer: cevaplarIndex);
  }

  /* static EmojiSubgroup randomSubListWithSize() {
    // List emojiSubListt = List<EmojiSubgroup>();
    List fixedSubGroup = EmojiSubgroup.values
        .where((o) => Emoji.bySubgroup(o).length > 3)
        .toList();
    // List list = List.generate(fixedSubGroup.length, (i) => i);
    // list.shuffle();

    // for (int i = 0; i < 4; i++) emojiSubListt.add(fixedSubGroup[list[i]]);
    return fixedSubGroup[rand.nextInt(fixedSubGroup.length)];
  }*/

  static EmojiSubgroup randomSubListWithSize(int size) {
    List<EmojiSubgroup> fixedSubGroup = EmojiSubgroup.values
        .where((o) => Emoji.bySubgroup(o).length > (size - 1))
        .toList();
    // debugPrint('subsize: ' + fixedSubGroup.length.toString());
    int randNumber = rand.nextInt(fixedSubGroup.length);

    return fixedSubGroup[randNumber];
  }

  static getLevel(int levelIndex) {
    if (levelIndex <= sayac.index)
      return level[levelIndex - 1];
    else
      return level[10];
  }
}

class Sayac {
  int index = 1;

  int getIndex() {
    // debugPrint(index.toString());
    return index++;
  }

  int getSubListIndex() {
    // debugPrint((index - 1).toString());
    return index - 1;
  }
}

class EmojiAndAnswer {
  List<Emoji> emoji;
  List emojiAnswer;

  EmojiAndAnswer({this.emoji, this.emojiAnswer});
}
