import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:flame_emoji_game/main.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';
import '../state.dart';

class MenuButton extends Component with HasGameRef<MyGame> {
  Rect rect;

  @override
  void render(Canvas c) {
    draw_icon(c);
  }

  @override
  void update(double t) {
    // TODO: implement update
  }

  draw_icon(Canvas c) {
    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontSize: 30,
            fontFamily: Icons.menu.fontFamily,
            color: Colors.black),
        text: String.fromCharCode(Icons.menu.codePoint));
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.rtl);
    tp.layout();
    // tp.layout(minWidth: 0, maxWidth: 0);
    Offset position = Offset(
      (gameRef.size.width) - (gameRef.size.width - tp.width / 2),
      (gameRef.size.height / 20) - (tp.height / 2),
    );
    rect = Rect.fromCircle(center: position, radius: 30);

    tp.paint(c, rect.center);
  }
}
