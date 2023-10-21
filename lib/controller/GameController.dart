import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tamahaem/controller/TamagotchiCounterController.dart';
import 'package:tamahaem/controller/ui/ActionDialog.dart';
import 'package:tamahaem/controller/ui/FriendlyGage.dart';
import 'package:tamahaem/controller/ui/TamagotchiMovement.dart';
import 'package:tamahaem/controller/ui/TamagotchiStatus.dart';
import 'package:tamahaem/event/impl/EventHandleProvider.dart';

import '../domain/Tamagotchi.dart';
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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child:
                    Image.asset("assets/images/background/homeBackground.png")),
          ),
          SizedBox(
              width: 0.1,
              height: 0.1,
              child: GameWidget(game: TamagotchiMovement())),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.05,
            child: ChangeNotifierProvider.value(
              value: EventHandlerProvider(),
              child: Consumer<EventHandlerProvider> (
                builder: (context, eventHandlerProvider, child) {
                  return Visibility(
                      visible: eventHandlerProvider.isEventActive,
                      child: ClipOval(
                          child: SizedBox.fromSize(
                            size:
                            Size.fromRadius(MediaQuery.of(context).size.width * 0.1),
                            child: eventHandlerProvider.currentEvent.eventImage,
                          )
                      )
                  );
                },
              ),
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.25,
              child: SizedBox(
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ChangeNotifierProvider.value(
                      value: Tamagotchi(),
                      child: Consumer<Tamagotchi> (
                          builder: (context, tamagotchi, child) {
                        return FriendlyGage(
                          key: ValueKey(tamagotchi.friendlyValue),
                          friendly: tamagotchi.friendlyValue,
                        );
                      }
                      )
                  )
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
