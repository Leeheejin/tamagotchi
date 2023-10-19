import 'package:flutter/cupertino.dart';
import 'package:tamahaem/domain/TamagotchiProvider.dart';

import '../../domain/Tamagotchi.dart';

class TamagotchiStatus extends StatelessWidget {
  Tamagotchi tamagotchi = TamagotchiProvider.instance.tamagotchi;

  String getHungerImage() {
    if (tamagotchi.hunger >= 75) {
      return "assets/images/status/75.jpg";
    }
    else if (tamagotchi.hunger >= 50) {
      return "assets/images/status/50.png";
    }
    else if (tamagotchi.hunger >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  String getThirstImage() {
    if (tamagotchi.thirst >= 75) {
      return "assets/images/status/75.jpg";
    }
    else if (tamagotchi.thirst >= 50) {
      return "assets/images/status/50.png";
    }
    else if (tamagotchi.thirst >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  String getHappinessImage() {
    if (tamagotchi.happiness >= 75) {
      return "assets/images/status/75.jpg";
    }
    else if (tamagotchi.happiness >= 50) {
      return "assets/images/status/50.png";
    }
    else if (tamagotchi.happiness >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
              width: 70,
              height: 70,
              child: Image.asset(getHungerImage()),
            ),
        SizedBox(
          width: 70,
          height: 70,
          child: Image.asset(getThirstImage()),
        ),
        SizedBox(
            width: 70,
            height: 70,
            child: Image.asset(getHappinessImage()),
          ),
      ],
    );
  }
}


