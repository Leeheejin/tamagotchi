import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../domain/Tamagotchi.dart';

class StatusBar extends StatelessWidget {
  String getHungerImage(int hunger) {
    if (hunger >= 75) {
      return "assets/images/status/hunger/75_satiety.png";
    } else if (hunger >= 50) {
      return "assets/images/status/hunger/50_satiety.png";
    } else {
      return "assets/images/status/hunger/25_satiety.png";
    }
  }

  String getThirstImage(int thirst) {
    if (thirst >= 75) {
      return "assets/images/status/water/75_water.png";
    } else if (thirst >= 50) {
      return "assets/images/status/water/50_water.png";
    } else {
      return "assets/images/status/water/25_water.png";
    }
  }

  String getHappinessImage(int happiness) {
    if (happiness >= 75) {
      return "assets/images/status/happiness/75_heart.png";
    } else if (happiness >= 50) {
      return "assets/images/status/happiness/50_heart.png";
    } else {
      return "assets/images/status/happiness/25_heart.png";
    }
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
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(getHungerImage(tamagotchi.hunger)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(getThirstImage(tamagotchi.thirst)),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.width * 0.2,
                  child: Image.asset(getHappinessImage(tamagotchi.happiness)),
                ),
              ],
            );
          },
        ));
  }
}
