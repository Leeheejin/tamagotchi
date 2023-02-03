import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class CareActionUI extends FlameGame {
  Vector2 _currentPosition = Vector2(-50, 150);
  Vector2 _nextPosition = Vector2(35, 150);
  final spriteSize = Vector2(120.0, 120.0); //48
  late EffectController effectController;
  late SpriteAnimation animation;
  late SpriteSheet spriteSheet;
  late SpriteSheet spriteSheet2;
  late SpriteAnimationComponent spriteAnimationComponent;
  late Effect effect;
  Logger logger = Logger();

  @override
  Future<void> onLoad() async {

    spriteSheet = SpriteSheet(
      image: await images.load('character/test.png'),
      srcSize: Vector2(120.0, 120.0),
    );

    spriteSheet2 = SpriteSheet(
      image: await images.load('item/food/tile011.png'),
      srcSize: Vector2(16.0, 16.0),
    );

    // to는 불러오는 이미지 row= 0, to 4은 아래직진 1,4 위직진, 2,4 좌직진, 3,4 우직진
    animation = spriteSheet.createAnimation(row: 3, stepTime: 0.3, to: 4);

    spriteAnimationComponent = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(2, 2), // 8
      position: Vector2(_currentPosition.x, _currentPosition.y),
      size: spriteSize,
    );


    effectController = EffectController(
      duration: 1,
      reverseDuration: 0,
      infinite: false,
      curve: Curves.linear
    );

    effect = MoveEffect.to(
      Vector2(_nextPosition.x, _nextPosition.y),
      effectController,
      onComplete: () => { arriveAnimation() }
    );

    add(
      spriteAnimationComponent
        ..add(
            effect
        ),
    );
  }

  void arriveAnimation() {

    spriteAnimationComponent.position = _nextPosition;

    spriteAnimationComponent.remove(effect);

    SpriteAnimation NewAnimation = spriteSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    spriteAnimationComponent.animation = NewAnimation;


    effectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    effect = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y),
        effectController,
        onComplete: () => { foodAnimation() }
    );

    spriteAnimationComponent
        .add(
        effect
    );
  }

  void foodAnimation() async {

    final spriteSize = Vector2(16.0, 16.0);

    SpriteAnimation animation2 = spriteSheet2.createAnimation(row: 0, stepTime: 0.1, to: 1);

    SpriteAnimationComponent spriteAnimationComponent2 = SpriteAnimationComponent(
      animation: animation2,
      scale: Vector2(4, 4), // 8
      position: Vector2(60, -100),
      size: spriteSize,
    );

    EffectController effectController2 = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    Effect effect2 = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y),
        effectController2,
      onComplete: () {
        spriteAnimationComponent2.position = _nextPosition;
      }
    );

    add(
      spriteAnimationComponent2
        ..add(
            effect2
        ),
    );

  }
}