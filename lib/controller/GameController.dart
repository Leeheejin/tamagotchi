import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tamahaem/controller/ui/ActionDialog.dart';
import 'package:tamahaem/controller/ui/FriendlyGage.dart';
import 'package:tamahaem/controller/ui/TamagotchiMovement.dart';
import 'package:tamahaem/controller/ui/TamagotchiStatus.dart';
import 'package:tamahaem/event/impl/EventHandleProvider.dart';
import 'package:tamahaem/controller/TamagotchiCounterController.dart';

import '../domain/TamagotchiProvider.dart';
import '../utils/SoundPlayer.dart';

class GameController extends StatefulWidget {
  const GameController({super.key});

  @override
  _GameControllerState createState() => _GameControllerState();
}

class _GameControllerState extends State<GameController> with AutomaticKeepAliveClientMixin<GameController> {
    SoundPlayer soundPlayer = SoundPlayer();
    late TamagotchiCounterController _tamagotchiPenaltyController;
    late TamagotchiStatus _tamagotchiStatus;
    var logger = Logger();

  @override
  void initState() {

    _tamagotchiPenaltyController = TamagotchiCounterController(() {
      setState(() {});
    });

    _tamagotchiStatus = TamagotchiStatus();

    super.initState();
  }

  @override
  void dispose() {
    _tamagotchiPenaltyController.stop();
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
              child: Column(),
            ),
          ),
          SizedBox(
              width: 0.1,
              height: 0.1,
              child: GameWidget(game: TamagotchiMovement())
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Visibility(
              visible: EventHandleProvider.instance.isEventActive,
              child: ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(MediaQuery.of(context).size.width * 0.1),
                child: EventHandleProvider.instance.currentEvent.eventImage,)
              )
            ),
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              left: MediaQuery.of(context).size.width * 0.25,
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.5,
                child: FriendlyGage(
                  key: ValueKey(TamagotchiProvider.instance.tamagotchi.friendlyValue),
                  friendly: TamagotchiProvider.instance.tamagotchi.friendlyValue,
                ),
              )
          ),
          Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              right: MediaQuery.of(context).size.width * 0.05,
              child: _tamagotchiStatus
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
                child: Icon(Icons.menu, size: 50,),
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
          origin: Offset(MediaQuery.of(context).size.width * 0.1, MediaQuery.of(context).size.height),
          scale: curve,
          child: ActionDialog(),
        );
      },
      transitionDuration: const Duration(seconds: 1),
    );
  }
}



