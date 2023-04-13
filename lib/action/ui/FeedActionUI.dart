import 'dart:async';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/controller/GameController.dart';

class FeedActionUI extends FlameGame {
  final BuildContext context;

  FeedActionUI({required this.context});

  //TODO 이미지 사이즈와 벡터 사이의 비율을 찾아내야 함. 이미지 사이즈 스펙 고정, 아이콘 스펙 고정 필요.
  final Vector2 _characterInitPosition = Vector2(-150, 100);
  final Vector2 _characterCenterPosition = Vector2(-50, 100);
  final Vector2 _foodInitPosition = Vector2(165, 000);
  final Vector2 _foodCenterPosition = Vector2(165, 350);
  final Vector2 _characterClosePosition = Vector2(300, 100);
  final spriteSize = Vector2(120.0, 120.0); //48

  late SpriteAnimationComponent characterAnimationComponent;
  late EffectController characterEffectController;
  late Effect characterEffect;
  late SpriteAnimation characterAnimation;
  late SpriteSheet characterSheet;

  late SpriteAnimationComponent foodDropAnimationComponent;
  late EffectController foodDropEffectController;
  late Effect foodDropEffect;
  late SpriteAnimation characterArriveAnimation;
  late SpriteSheet foodSheet;

  late SpriteAnimation foodDropAnimation;
  late SpriteAnimation characterEatAnimation;
  late SpriteAnimation characterEatDoneAnimation;

  int MAX_EAT_ANIMATION_REPEAT = 2;
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

    characterAnimationComponent = SpriteAnimationComponent(
      animation: characterAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_characterInitPosition.x, _characterInitPosition.y),
      size: spriteSize,
    );


    characterEffectController = EffectController(
      duration: 1,
      reverseDuration: 0,
      infinite: false,
      curve: Curves.linear
    );

    characterEffect = MoveEffect.to(
      Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
      characterEffectController,
      onComplete: () => { characterArrive() }
    );

    add(
      characterAnimationComponent
        ..add(
            characterEffect
        ),
    );
  }

  void characterArrive() {

    characterAnimationComponent.position = _characterCenterPosition;

    characterAnimationComponent.remove(characterEffect);

    characterArriveAnimation = characterSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    characterAnimationComponent.animation = characterArriveAnimation;


    characterEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    characterEffect = MoveEffect.to(
        Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
        characterEffectController,
        onComplete: () => { foodDrop() }
    );

    characterAnimationComponent
        .add(
        characterEffect
    );
  }

  void foodDrop() async {

    final spriteSize = Vector2(16.0, 16.0);

    foodDropAnimation = foodSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    foodDropAnimationComponent = SpriteAnimationComponent(
      animation: foodDropAnimation,
      scale: Vector2(6, 6), // 8
      position: _foodInitPosition,
      size: spriteSize,
    );

    foodDropEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    foodDropEffect = MoveEffect.to(
        Vector2(_foodCenterPosition.x, _foodCenterPosition.y),
        foodDropEffectController,
      onComplete: () {
        foodDropAnimationComponent.position = _foodCenterPosition;
        foodDropAnimationComponent.opacity = 0;
        eat();
      }
    );

    add(
      foodDropAnimationComponent
        ..add(
            foodDropEffect
        ),
    );

  }

  // When the animation of the food coming down from above is over, the animation of the character eating the food is exposed.
  void eat([int repeat = 1]) {

    // setting eating animation
    characterEatAnimation = characterSheet.createAnimation(row: 1, stepTime: 0.1, to: 2);

    // setting animation component
    characterAnimationComponent.animation = characterEatAnimation;

    // setting effect controller
    characterEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    // setting effect
    characterEffect = MoveEffect.to(
        Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
        characterEffectController,
        onComplete: () => {

          if (repeat > MAX_EAT_ANIMATION_REPEAT) {
            eatingDone()
          } else {
            eat(repeat + 1)
          }
        }
    );

    // adding effect to animation component
    characterAnimationComponent
        .add(
        characterEffect
    );
  }

  void eatingDone() {

    // after 2 times of eating animation, the character goes to the end of right position.
    characterAnimationComponent.position = _characterCenterPosition;

    // removing effect from animation component
    characterAnimationComponent.remove(characterEffect);

    // setting animation
    characterEatDoneAnimation = characterSheet.createAnimation(row: 3, stepTime: 0.1, to: 4);

    // setting animation component
    characterAnimationComponent.animation = characterEatDoneAnimation;

    // setting effect controller
    characterEffectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    // setting effect
    characterEffect = MoveEffect.to(
        Vector2(_characterClosePosition.x, _characterClosePosition.y),
        characterEffectController,
        onComplete: () => {
          characterAnimationComponent.position = _characterClosePosition,
          logger.d("eating done animation complete"),
          close()
        }
    );

    // adding effect to animation component
    characterAnimationComponent
        .add(
        characterEffect
    );
  }

  void close() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const GameController()));
  }

}

