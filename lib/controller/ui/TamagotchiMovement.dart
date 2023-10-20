import 'dart:async';
import 'dart:math';

import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class TamagotchiMovement extends FlameGame {
  Vector2 _currentPosition = Vector2(45, 450);
  Vector2 _nextPosition = Vector2(45, 450);
  final spriteSize = Vector2(120.0, 120.0); //48
  MovingDirection _direction = MovingDirection.Down;
  late EffectController effectController;
  late SpriteAnimation animation;
  late SpriteSheet spriteSheet;
  late SpriteAnimationComponent spriteAnimationComponent;
  late Effect effect;
  Logger logger = Logger();
  late Timer timer;

  @override
  Future<void> onLoad() async {

    spriteSheet = SpriteSheet(
      image: await images.load('character/test.png'),
      srcSize: Vector2(120.0, 120.0),
    );

    // to는 불러오는 이미지 row= 0, to 4은 아래직진 1,4 위직진, 2,4 좌직진, 3,4 우직진
    animation = spriteSheet.createAnimation(row: _direction.index, stepTime: 0.1, to: _direction.index + 1);

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
      onComplete: () => { updatePosition() }
    );

    add(
      spriteAnimationComponent
        ..add(
            effect
        ),
    );
  }

  void updatePosition() {

    _currentPosition = _nextPosition;
    _nextPosition = getRandomNextPosition();

    spriteAnimationComponent.remove(effect);

    SpriteAnimation NewAnimation = spriteSheet.createAnimation(row: _direction.index, stepTime: 0.1, to: 3);

    spriteAnimationComponent.animation = NewAnimation;
    spriteAnimationComponent.position = _currentPosition;

    effectController = EffectController(
        duration: 3,
        reverseDuration: 0,
        infinite: false,
        curve: Curves.linear
    );

    effect = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y),
        effectController,
        onComplete: () => { updatePosition() }
    );

    spriteAnimationComponent.add(effect);
  }


  Vector2 getRandomNextPosition() {

    bool direction = Random().nextBool();
    double x = _currentPosition.x;
    double y = _currentPosition.y;

    if (direction) {
      x = checkXBound(_currentPosition.x, getRandomPosition());
    } else {
      y = checkYBound(_currentPosition.y, getRandomPosition());
    }

    return Vector2(x, y);
  }

  double getRandomPosition() {
    bool positive = Random().nextBool();

    if (positive) {
      return 25 + Random().nextDouble() * 75;
    }

    return 25 + Random().nextDouble() * 75 * -1;
  }

  //TODO screen size refactor need.
  //TODO make sub page that limits chracters move range.
  double checkXBound(double point, double addition) {

    if (addition > 0) {
      _direction = MovingDirection.Right;
    } else {
      _direction = MovingDirection.Left;
    }

    if (point + addition > 180) {
      return 180;
    } else if (point + addition < -80) {
      return -80;
    } else {
      return point + addition;
    }
  }

  double checkYBound(double point, double addition) {

    if (addition > 0) {
      _direction = MovingDirection.Down;
    } else {
      _direction = MovingDirection.Up;
    }

    if (point + addition > 500) {
      return 500;
    } else if (point + addition <= 0) {
      return 0;
    } else {
      return point + addition;
    }
  }
}

enum MovingDirection {
  Down, // 0
  Up,  // 1
  Left, // 2
  Right // 3
}