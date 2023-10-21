import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
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
    double x = _currentPosition.x;
    double y = _currentPosition.y;

    // Check proximity to edges
    double leftProximity = (x + 80) / 260;  // Range: [0, 1] where 1 is very close to the left edge
    double rightProximity = (180 - x) / 260; // Range: [0, 1] where 1 is very close to the right edge
    // Assuming similar boundaries for y-axis
    double topProximity = (y + 80) / 260;
    double bottomProximity = (180 - y) / 260;

    // We'll use these proximities to determine if we should favor x or y movement
    double xBias = leftProximity + rightProximity;
    double yBias = topProximity + bottomProximity;
    bool favorX = Random().nextDouble() < (0.5 + xBias * 0.25);

    if (favorX) {
      if (leftProximity > rightProximity) {
        x = checkXBound(x, getRandomPosition().abs());
      } else {
        x = checkXBound(x, -getRandomPosition().abs());
      }
    } else {
      if (topProximity > bottomProximity) {
        y = checkYBound(y, getRandomPosition().abs());
      } else {
        y = checkYBound(y, -getRandomPosition().abs());
      }
    }

    return Vector2(x, y);
  }

  double getRandomPosition() {
    double magnitude = 50.0 + GaussianDistribution().next() * 25.0;
    double sign = Random().nextBool() ? 1.0 : -1.0;
    return magnitude * sign;
  }

  //TODO screen size refactor need.
  //TODO make sub page that limits characters move range.
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

class GaussianDistribution {
  final Random _random = Random();

  double next() {
    // Using Box-Muller transform to get numbers in a Gaussian distribution
    double u1 = _random.nextDouble();
    double u2 = _random.nextDouble();
    double z0 = sqrt(-2.0 * log(u1)) * cos(2 * pi * u2);
    return z0;
  }
}