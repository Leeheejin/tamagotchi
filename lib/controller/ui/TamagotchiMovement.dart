import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/game.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class TamagotchiMovement extends FlameGame {
  Vector2 _currentPosition = Vector2(0, 0); //45, 450
  Vector2 _nextPosition = Vector2(0, 0); // 45, 450
  late Vector2 _spriteSize = Vector2(120, 120); // 48
  MovingDirection _direction = MovingDirection.Down;
  late EffectController effectController;
  late SpriteAnimation animation;
  late SpriteSheet spriteSheet;
  late SpriteAnimationComponent spriteAnimationComponent;
  late Effect effect;
  Logger logger = Logger();
  late Timer timer;

  late double xMin;
  late double xMax;

  late double yMin;
  late double yMax;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    print("${size.x} ${size.y}");

    _currentPosition = Vector2(0, 0);
    _nextPosition = _currentPosition;

    xMin = -100;
    xMax = 100;

    yMin = -100;
    yMax = 100;

    _spriteSize = Vector2(120, 120);

    spriteSheet = SpriteSheet(
      image: await images.load('character/ham.png'),
      srcSize: Vector2(_spriteSize.x, _spriteSize.y),
    );

    // to는 불러오는 이미지 row= 0, to 4은 아래직진 1,4 위직진, 2,4 좌직진, 3,4 우직진
    animation = spriteSheet.createAnimation(
        row: _direction.index, stepTime: 0.1, to: _direction.index + 1);

    spriteAnimationComponent = SpriteAnimationComponent(
      animation: animation,
      scale: Vector2(2, 2), // 8
      position: Vector2(_currentPosition.x, _currentPosition.y),
      size: _spriteSize,
    );

    effectController = EffectController(
        duration: 1, reverseDuration: 0, infinite: false, curve: Curves.linear);

    effect = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y), effectController,
        onComplete: () => {updatePosition()});

    add(
      spriteAnimationComponent..add(effect),
    );
  }

  void updatePosition() {
    _currentPosition = _nextPosition;
    _nextPosition = getRandomNextPosition();

    spriteAnimationComponent.remove(effect);

    SpriteAnimation NewAnimation = spriteSheet.createAnimation(
        row: _direction.index, stepTime: 0.1, to: 3);

    spriteAnimationComponent.animation = NewAnimation;
    spriteAnimationComponent.position = _currentPosition;

    effectController = EffectController(
        duration: 3, reverseDuration: 0, infinite: false, curve: Curves.linear);

    effect = MoveEffect.to(
        Vector2(_nextPosition.x, _nextPosition.y), effectController,
        onComplete: () => {updatePosition()});

    spriteAnimationComponent.add(effect);
  }

  Vector2 getRandomNextPosition() {
    double x = _currentPosition.x;
    double y = _currentPosition.y;

    // Calculate biases based on distance from each edge
    double leftBias = (x + xMin) / (xMax + xMin.abs());
    double rightBias = (xMax - x) / (xMax + xMin.abs());
    double topBias = (y + yMin) / (yMax + yMin.abs());
    double bottomBias = (yMax - y) / (yMax + yMin.abs());

    // Decide on x-axis movement
    bool moveRight = Random().nextDouble() < rightBias / (leftBias + rightBias);

    // Decide on y-axis movement
    bool moveDown = Random().nextDouble() < bottomBias / (topBias + bottomBias);

    // If close to an edge, have a stronger bias to move away from that edge
    double edgeBuffer = 50; // Adjust as needed

    if (x < xMin + edgeBuffer) moveRight = true;
    if (x > xMax - edgeBuffer) moveRight = false;
    if (y < yMin + edgeBuffer) moveDown = true;
    if (y > yMax - edgeBuffer) moveDown = false;

    x = checkXBound(x, getRandomPosition(moveRight));
    y = checkYBound(y, getRandomPosition(moveDown));

    if (moveRight) {
      if (moveDown) {
        if (x > y) {
          _direction = MovingDirection.Right;
        } else {
          _direction = MovingDirection.Down;
        }
      } else {
        if (x > y) {
          _direction = MovingDirection.Right;
        } else {
          _direction = MovingDirection.Up;
        }
      }
    } else {
      if (moveDown) {
        if (x > y) {
          _direction = MovingDirection.Left;
        } else {
          _direction = MovingDirection.Down;
        }
      } else {
        if (x > y) {
          _direction = MovingDirection.Left;
        } else {
          _direction = MovingDirection.Up;
        }
      }
    }

    //logger.v("$x, $y");
    return Vector2(x, y);
  }

  double getRandomPosition([bool positiveDirection = true]) {
    double magnitude = 50.0 + GaussianDistribution().next() * 25.0;
    if (!positiveDirection) magnitude *= -1;
    return magnitude;
  }

  //TODO screen size refactor need.
  //TODO make sub page that limits characters move range.
  double checkXBound(double point, double addition) {
    if (point + addition > xMax) {
      return xMax;
    } else if (point + addition < xMin) {
      return xMin;
    } else {
      return point + addition;
    }
  }

  double checkYBound(double point, double addition) {
    if (point + addition > yMax) {
      return yMax;
    } else if (point + addition <= yMin) {
      return yMin;
    } else {
      return point + addition;
    }
  }
}

enum MovingDirection {
  Down, // 0
  Up, // 1
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
