import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../domain/Tamagotchi.dart';

class TamagotchiStatus extends StatelessWidget {
  String getHungerImage(int hunger) {
    if (hunger >= 75) {
      return "assets/images/status/75.jpg";
    } else if (hunger >= 50) {
      return "assets/images/status/50.png";
    } else if (hunger >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  String getThirstImage(int thirst) {
    if (thirst >= 75) {
      return "assets/images/status/75.jpg";
    } else if (thirst >= 50) {
      return "assets/images/status/50.png";
    } else if (thirst >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  String getHappinessImage(int happiness) {
    if (happiness >= 75) {
      return "assets/images/status/75.jpg";
    } else if (happiness >= 50) {
      return "assets/images/status/50.png";
    } else if (happiness >= 25) {
      return "assets/images/status/25.png";
    }

    return "assets/images/status/zero.png";
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: Tamagotchi(),
        child: Consumer<Tamagotchi>(
          builder: (context, tamagotchi, child) {
            return Column(
              children: <Widget>[
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(getHungerImage(tamagotchi.hunger)),
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(getThirstImage(tamagotchi.thirst)),
                ),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: Image.asset(getHappinessImage(tamagotchi.happiness)),
                ),
              ],
            );
          },
        ));
  }
}
