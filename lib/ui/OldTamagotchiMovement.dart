// import 'dart:async';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:logger/logger.dart';
//
// import '../domain/TamagotchiProvider.dart';
//
// enum MovingDirection {
//   Left,
//   Up,
//   Right,
//   Down,
// }
//
// class TamagotchiMovement extends StatefulWidget {
//   const TamagotchiMovement({super.key});
//
//   @override
//   _TamagotchiMovementState createState() => _TamagotchiMovementState();
// }
//
// class _TamagotchiMovementState extends State<TamagotchiMovement> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<Offset> _animation;
//   final Random _random = Random();
//   var logger = Logger();
//   Offset _currentPosition = Offset(200, 200);
//   Offset _nextPosition = Offset(0, 0);
//   MovingDirection _direction = MovingDirection.Down;
//   late Timer _timer;
//
//   @override
//   void initState() {
//
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 1),
//     )..repeat();
//
//     _animation = Tween<Offset>(
//       begin: _currentPosition,
//       end: _nextPosition,
//     ).animate(_animationController);
//
//     startTimer();
//
//     super.initState();
//   }
//
//   void startTimer() {
//     const oneSec = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       oneSec,
//           (Timer timer) {
//
//             _animationController.reset();
//
//             //logger.d("$_currentPosition");
//             //logger.d("$_nextPosition");
//
//             setState(() {
//               _currentPosition = _nextPosition;
//               _nextPosition = getRandomNextPosition();
//
//               _animation = Tween<Offset>(
//                 begin: _currentPosition,
//                 end: _nextPosition,
//               ).animate(_animationController);
//             });
//
//             _animationController.repeat();
//       },
//     );
//   }
//
//   Offset getRandomNextPosition() {
//       bool direction = _random.nextBool();
//       double x = _currentPosition.dx;
//       double y = _currentPosition.dy;
//
//       if (direction) {
//         x = checkXBound(_currentPosition.dx, getRandomPosition());
//       } else {
//         y = checkYBound(_currentPosition.dy, getRandomPosition());
//       }
//
//       return Offset(x, y);
//   }
//
//   double getRandomPosition() {
//     bool positive = _random.nextBool();
//
//     if (positive) {
//       return _random.nextDouble() * 10 * -1;
//     }
//
//     return _random.nextDouble() * 10;
//   }
//
//   //TODO screen size refactor need.
//   //TODO make sub page that limits chracters move range.
//   double checkXBound(double point, double addition) {
//
//     if (addition > 0) {
//       _direction = MovingDirection.Left;
//     } else {
//       _direction = MovingDirection.Right;
//     }
//
//     if (point + addition <= MediaQuery.of(context).size.width * 0.8 && point + addition >= 0) {
//       return point + addition;
//     }
//
//     return point;
//   }
//
//   double checkYBound(double point, double addition) {
//
//     if (addition > 0) {
//       _direction = MovingDirection.Up;
//     } else {
//       _direction = MovingDirection.Down;
//     }
//
//     if (point + addition <= 300 && point + addition >= 0) {
//       return point + addition;
//     }
//
//     return point;
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: MediaQuery.of(context).size.width * 0.8,
//       height: MediaQuery.of(context).size.height / 2,
//       child: Column(
//         children: [
//           AnimatedBuilder(
//             animation: _animation,
//             builder: (BuildContext context, Widget? child) {
//               return Transform.translate(
//                 offset: _animation.value,
//                 child: child,
//               );
//             },
//             child: SizedBox(
//               height: 100,
//               width: 100,
//               child: Image.asset(TamagotchiProvider().tamagotchi.getImage()),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }