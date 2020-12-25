import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame_emoji_game/game_controller.dart';
import 'package:flame_emoji_game/giris.dart';
import 'package:flame/palette.dart';
import 'package:flame/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'tools/bgm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Util flameUtil = Util();
  final size = await flameUtil.initialDimensions();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.portraitUp);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Flame.audio.disableLog();
  Flame.audio.loadAll(<String>[
    'bgm/Ding.mp3',
    'bgm/lose.wav',
  ]);
  BGM.attachWidgetBindingListener();
  // BGM.removeAll();
  await BGM.add('bgm/playing-background.mp3');

  runApp(MyApp(size, prefs));
}

class Palette {
  static const PaletteEntry white = BasicPalette.white;
  static const PaletteEntry red = PaletteEntry(Color(0xFFFF0000));
  static const PaletteEntry blue = PaletteEntry(Color(0xFF0000FF));
}
