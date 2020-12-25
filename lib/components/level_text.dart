import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame_emoji_game/main.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';
import '../state.dart';

class LevelText extends Component with HasGameRef<MyGame> {
  @override
  void render(Canvas c) {
    // c.drawRect(Rect.fromLTWH(0, 0, width, height), Palette.white.paint);
    //  if(gameRef.state == States.menu)
    draw_emoji(c);
    // c.drawRect(const Rect.fromLTWH(0, 0, 3, 3), Palette.red.paint);
    // c.drawRect(Rect.fromLTWH(width / 2, height / 2, 3, 3), Palette.blue.paint);
  }

  draw_emoji(Canvas c) {
    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: 30, color: Colors.blue, fontWeight: FontWeight.bold),
        text: 'Level ${gameRef.level.levelIndex}');
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl);
    tp.layout();
    // tp.layout(minWidth: 0, maxWidth: 0);
    Offset position = Offset(
      (gameRef.size.width / 2) - (tp.width / 2),
      (gameRef.size.height / 20) - (tp.height / 2),
    );
    tp.paint(c, position);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
