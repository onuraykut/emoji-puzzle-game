import 'package:flame/anchor.dart';
import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/has_game_ref.dart';
import 'package:flame/sprite.dart';
import 'package:flame_emoji_game/main.dart';
import 'package:flutter/material.dart';

import '../game_controller.dart';
import '../state.dart';

class SoundButton extends Component with HasGameRef<MyGame> {
  Rect rect;
  Sprite enabledSprite;
  Sprite disabledSprite;
  bool isEnabled = true;

  SoundButton(Size size) {
    enabledSprite = Sprite('ui/icon-sound-enabled.png');
    disabledSprite = Sprite('ui/icon-sound-disabled.png');
    rect = Rect.fromLTWH(
      size.width * 0.7,
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
