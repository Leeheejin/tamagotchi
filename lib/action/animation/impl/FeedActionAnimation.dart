import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../AbstractActionAnimation.dart';

class FeedActionAnimation extends AbstractActionAnimation {
  final BuildContext context;
  final int currentStep;
  final VoidCallback onCompleted;

  FeedActionAnimation(
      {required this.context,
      required this.currentStep,
      required this.onCompleted});

  //TODO 이미지 사이즈와 벡터 사이의 비율을 찾아내야 함. 이미지 사이즈 스펙 고정, 아이콘 스펙 고정 필요.
  late Vector2 _characterInitPosition;
  late Vector2 _characterCenterPosition;
  late Vector2 _foodInitPosition;
  late Vector2 _foodCenterPosition;
  late Vector2 _characterClosePosition;
  final spriteSize = Vector2(120.0, 120.0); //48

  late SpriteSheet characterSheet;
  late SpriteSheet foodSheet;

  late SpriteAnimationComponent characterAppearAnimationComponent;
  late EffectController characterAppearEffectController;
  late Effect characterAppearEffect;
  late SpriteAnimation characterAppearAnimation;

  late SpriteAnimationComponent characterArriveAnimationComponent;
  late EffectController characterArriveEffectController;
  late Effect characterArriveEffect;
  late SpriteAnimation characterArriveAnimation;

  late SpriteAnimationComponent foodDropAnimationComponent;
  late EffectController foodDropEffectController;
  late Effect foodDropEffect;
  late SpriteAnimation foodDropAnimation;

  late SpriteAnimationComponent characterEatAnimationComponent;
  late EffectController characterEatEffectController;
  late Effect characterEatEffect;
  late SpriteAnimation characterEatAnimation;

  late SpriteAnimationComponent characterEatingDoneAnimationComponent;
  late EffectController characterEatingDoneEffectController;
  late Effect characterEatingDoneEffect;
  late SpriteAnimation characterEatingDoneAnimation;

  Logger logger = Logger();

  @override
  Future<void> onLoad() async {
    await initSheet();
    initPosition();

    switch (currentStep) {
      case 0:
        characterAppear();
        break;
      case 1:
        characterArrived();
        foodDrop();
        break;
      case 2:
        characterArrived();
        eat();
        break;
      case 3:
        super.dispose();
        break;
      default:
        // Code for the default animation if no specific step is provided...
        break;
    }
  }

  Future<void> initSheet() async {
    characterSheet = SpriteSheet(
      image: await images.load('character/ham.png'),
      srcSize: Vector2(120.0, 120.0),
    );

    foodSheet = SpriteSheet(
      image: await images.load('item/food/tile011.png'),
      srcSize: Vector2(16.0, 16.0),
    );
  }

  void initPosition() {
    _characterInitPosition = Vector2(-150, 100);
    _characterCenterPosition = Vector2(-50, 100);
    _foodInitPosition = Vector2(165, 000);
    _foodCenterPosition = Vector2(165, 350);
    _characterClosePosition = Vector2(300, 100);
  }

  void characterAppear() {
    // to는 불러오는 이미지 row= 0, to 4은 아래직진 1,4 위직진, 2,4 좌직진, 3,4 우직진
    characterAppearAnimation =
        characterSheet.createAnimation(row: 3, stepTime: 0.3, to: 4);

    characterAppearAnimationComponent = SpriteAnimationComponent(
      animation: characterAppearAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_characterInitPosition.x, _characterInitPosition.y),
      size: spriteSize,
    );

    characterAppearEffectController = EffectController(
        duration: 1, reverseDuration: 0, infinite: false, curve: Curves.linear);

    characterAppearEffect = MoveEffect.to(
        Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
        characterAppearEffectController, onComplete: () {
      characterAppearAnimationComponent.position = _characterCenterPosition;
      characterAppearAnimationComponent.removeFromParent();
      characterArrived(true);
    });

    add(
      characterAppearAnimationComponent..add(characterAppearEffect),
    );
  }

  void characterArrived([bool needCompleted = false]) {
    characterArriveAnimation =
        characterSheet.createAnimation(row: 0, stepTime: 0.1, to: 1);

    characterArriveAnimationComponent = SpriteAnimationComponent(
      animation: characterArriveAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
      size: spriteSize,
    );

    characterArriveEffectController = EffectController(
        duration: 1, reverseDuration: 0, infinite: false, curve: Curves.linear);

    characterArriveEffect = MoveEffect.to(
        Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
        characterArriveEffectController, onComplete: () {
      if (needCompleted) {
        onCompleted();
      }
    });

    add(
      characterArriveAnimationComponent..add(characterArriveEffect),
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
        duration: 1, reverseDuration: 0, infinite: false, curve: Curves.linear);

    foodDropEffect = MoveEffect.to(
        Vector2(_foodCenterPosition.x, _foodCenterPosition.y),
        foodDropEffectController, onComplete: () {
      foodDropAnimationComponent.position = _foodCenterPosition;
      onCompleted();
    });

    add(
      foodDropAnimationComponent..add(foodDropEffect),
    );
  }

  // When the animation of the food coming down from above is over, the animation of the character eating the food is exposed.
  void eat() {
    characterEatAnimation =
        characterSheet.createAnimation(row: 1, stepTime: 0.1, to: 2);

    characterEatAnimationComponent = SpriteAnimationComponent(
      animation: characterEatAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
      size: spriteSize,
    );

    // setting effect controller
    characterEatEffectController = EffectController(
        duration: 2, reverseDuration: 0, infinite: false, curve: Curves.linear);

    // setting effect
    characterEatEffect = MoveEffect.to(
        Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
        characterEatEffectController, onComplete: () {
      characterEatAnimationComponent.removeFromParent();
      characterArriveAnimationComponent.removeFromParent();
      eatingDone();
    });

    // adding effect to animation component
    add(
      characterEatAnimationComponent..add(characterEatEffect),
    );
  }

  void eatingDone() {
    characterEatingDoneAnimation =
        characterSheet.createAnimation(row: 3, stepTime: 0.1, to: 4);

    characterEatingDoneAnimationComponent = SpriteAnimationComponent(
      animation: characterEatingDoneAnimation,
      scale: Vector2(3, 3), // 8
      position: Vector2(_characterCenterPosition.x, _characterCenterPosition.y),
      size: spriteSize,
    );

    // setting effect controller
    characterEatingDoneEffectController = EffectController(
        duration: 1, reverseDuration: 0, infinite: false, curve: Curves.linear);

    // setting effect
    characterEatingDoneEffect = MoveEffect.to(
        Vector2(_characterClosePosition.x, _characterClosePosition.y),
        characterEatingDoneEffectController, onComplete: () {
      characterEatingDoneAnimationComponent.position = _characterClosePosition;
      characterEatingDoneAnimationComponent.removeFromParent();
      onCompleted();
    });

    // adding effect to animation component
    add(characterEatingDoneAnimationComponent..add(characterEatingDoneEffect));
  }
}
