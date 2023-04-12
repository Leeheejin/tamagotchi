import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class FeedActionUI extends FlameGame {
  //TODO 이미지 사이즈와 벡터 사이의 비율을 찾아내야 함. 이미지 사이즈 스펙 고정, 아이콘 스펙 고정 필요.
  Vector2 _currentPosition = Vector2(-150, 100);
  Vector2 _nextPosition = Vector2(-50, 100);
  Vector2 _currentPosition2 = Vector2(165, 000);
  Vector2 _nextPosition2 = Vector2(165, 350);
  final spriteSize = Vector2(120.0, 120.0); //48
  late EffectController characterEffectController;
  late SpriteAnimation characterAnimation;
  late SpriteSheet characterSheet;
  late SpriteSheet foodSheet;
  late SpriteAnimationComponent spriteAnimationComponent;
  late Effect effect;
  Logger logger = Logger();

  @override
  Future<void> onLoad() async {

    characterSheet = SpriteSheet(
      image: await images.load('character/test.png'),
      srcSize: Vector2(120.0, 120.0),
    );

    foodSheet = SpriteSheet(
      image: await images.load('item/food/tile011.png'),
      srcSize: Vector2(16.0, 16.0),
    );

    // to는 불러오는 이미지 row= 0, to 4은 아래직진 1,4 위직진, 2,4 좌직진, 3,4 우직진
    characterAnimation = characterSheet.createAnimation(row: 3, stepTime: 0.3, to: 4);

    spriteAnimationComponent = SpriteAnimationComponent(
      animation: characterAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_currentPosition.x, _currentPosition.y),
      size: spriteSize,
    );


    characterEffectController = EffectController(
      duration: 1,
      reverseDuration: 0,
      infinite: false,
      curve: Curves.linear
    );

    effect = MoveEffect.to(
      Vector2(_nextPosition.x, _nextPosition.y),
      characterEffectController,
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

    SpriteAnimation characterArriveAnimation = characterSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    spriteAnimationComponent.animation = characterArriveAnimation;


    characterEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    effect = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y),
        characterEffectController,
        onComplete: () => { foodDropAnimation() }
    );

    spriteAnimationComponent
        .add(
        effect
    );
  }

  void foodDropAnimation() async {

    final spriteSize = Vector2(16.0, 16.0);

    SpriteAnimation foodDropAnimation = foodSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    SpriteAnimationComponent foodDropAnimationComponent = SpriteAnimationComponent(
      animation: foodDropAnimation,
      scale: Vector2(6, 6), // 8
      position: _currentPosition2,
      size: spriteSize,
    );

    EffectController foodDropEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    Effect foodDropEffect = MoveEffect.to(
        Vector2(_nextPosition2.x, _nextPosition2.y),
        foodDropEffectController,
      onComplete: () {
        foodDropAnimationComponent.position = _nextPosition2;
      }
    );

    add(
      foodDropAnimationComponent
        ..add(
            foodDropEffect
        ),
    );

  }

  void foodEatingAnimation() {
    //todo: food eating animation.
  }


}

