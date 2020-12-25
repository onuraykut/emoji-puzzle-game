import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:flame_emoji_game/main.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';
import '../state.dart';

class MusicButton extends Component with HasGameRef<MyGame> {
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  MusicButton(Size size) {
    enabledSprite = Sprite('ui/icon-music-enabled.png');
    disabledSprite = Sprite('ui/icon-music-disabled.png');
    rect = Rect.fromLTWH(
      size.width * 0.8,
      size.height / 30,
      size.width * 0.1,
      size.height * 0.04,
    );
  }

  @override
  void render(Canvas c) {
    if (isEnabled) {
      enabledSprite.renderRect(c, rect);
    } else {
      disabledSprite.renderRect(c, rect);
    }
  }

  @override
  void update(double t) {
    // TODO: implement update
  }
}
