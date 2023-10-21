import 'dart:ffi';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shake_animated/flutter_shake_animated.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tamahaem/controller/TamagotchiCounterController.dart';
import 'package:tamahaem/controller/ui/ActionDialog.dart';
import 'package:tamahaem/controller/ui/FriendlyGage.dart';
import 'package:tamahaem/controller/ui/TamagotchiMovement.dart';
import 'package:tamahaem/controller/ui/TamagotchiStatus.dart';

import '../domain/Tamagotchi.dart';
import '../event/EventHandleProvider.dart';
import '../utils/Constants.dart';
import '../utils/SoundPlayer.dart';

class GameController extends StatefulWidget {
  const GameController({super.key});

  @override
  _GameControllerState createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController>
    with AutomaticKeepAliveClientMixin<GameController> {
  SoundPlayer soundPlayer = SoundPlayer();
  late TamagotchiCounterController _tamagotchiCounterController;
  var logger = Logger();

  @override
  void initState() {
    _tamagotchiCounterController = TamagotchiCounterController(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _tamagotchiCounterController.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset("assets/images/background/homeBackground.png", fit: BoxFit.cover,)
            )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
              child: Center(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: GameWidget(
                        game: TamagotchiMovement(),
                    ),
                )
              )
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.05,
            child: ChangeNotifierProvider.value(
              value: EventHandlerProvider(),
              child: Consumer<EventHandlerProvider> (
                builder: (context, eventHandlerProvider, child) {
                  return Visibility(
                      visible: eventHandlerProvider.isEventActive,
                      child:
                      ShakeWidget(
                        duration: Duration(seconds: 5),
                        shakeConstant: ShakeHorizontalConstant2(),
                        autoPlay: true,
                        enableWebMouseHover: false,
                        child: CircleAvatar(
                          radius: MediaQuery.of(context).size.height * 0.045,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundImage: eventHandlerProvider.currentEvent.eventImage,
                            radius: MediaQuery.of(context).size.height * 0.035,
                          ),
                        )
                      ),
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              child: Center(
                child: ChangeNotifierProvider.value(
                    value: Tamagotchi(),
                    child: Consumer<Tamagotchi> (
                        builder: (context, tamagotchi, child) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: FriendlyGage(
                              key: ValueKey(tamagotchi.friendlyValue),
                              friendly: tamagotchi.friendlyValue,
                            ),
                          );
                        }
                    )
                ),
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              right: MediaQuery.of(context).size.width * 0.05,
              child: TamagotchiStatus()
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: MediaQuery.of(context).size.width * 0.1,
            child: GestureDetector(
              onTap: () {
                _scaleDialog(context);
              },
              child: const SizedBox(
                height: 100,
                width: 100,
                child: Icon(
                  Icons.menu,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _scaleDialog(context) {
    showGeneralDialog(
      barrierColor: Colors.white.withOpacity(0),
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          origin: Offset(MediaQuery.of(context).size.width * 0.1,
              MediaQuery.of(context).size.height),
          scale: curve,
          child: ActionDialog(),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }
}
