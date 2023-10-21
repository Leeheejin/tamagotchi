import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum TamagotchiStage { EGG, BABY, TEEN, ADULT }

class Tamagotchi extends ChangeNotifier {

  static final Tamagotchi _instance = Tamagotchi._internal();

  factory Tamagotchi() {
    return _instance;
  }

  Tamagotchi._internal() {
   load();
  }

  TamagotchiStage _currentStage = TamagotchiStage.EGG;
  double _friendlyValue = 0.5;
  int _age = 0;
  int _hunger = 50;
  int _thirst = 50;
  int _happiness = 50;

  int get hunger => _hunger;
  int get thirst => _thirst;
  int get happiness => _happiness;
  double get friendlyValue => _friendlyValue;
  int get stageIndex => _currentStage.index;
  TamagotchiStage get currentState => _currentStage;
  int get age => _age;

  Future<void> save() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('hunger', hunger);
    await prefs.setInt('thirst', thirst);
    await prefs.setInt('happiness', happiness);
    await prefs.setDouble('friendly', _friendlyValue);
    await prefs.setInt('age', age);
  }

  Future<void> load() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _hunger = prefs.getInt('hunger') ?? 50;
    _thirst = prefs.getInt('thirst') ?? 50;
    _happiness = prefs.getInt('happiness') ?? 50;
    _friendlyValue = prefs.getDouble("friendly") ?? 0.5;
    _currentStage = TamagotchiStage.values[prefs.getInt('growthStage') ?? 0];
    _age = prefs.getInt("age") ?? 0;
  }

  String getImage() {
    switch (_currentStage) {
      case TamagotchiStage.EGG:
        return "assets/images/character/tamagotchi.png";
      case TamagotchiStage.BABY:
        return "assets/images/character/tamagotchi.png";
      case TamagotchiStage.TEEN:
        return "assets/images/character/tamagotchi.png";
      case TamagotchiStage.ADULT:
        return "assets/images/character/tamagotchi.png";
    }
  }

  // String getImage() {
  //   switch (_currentStage) {
  //     case TamagotchiStage.EGG:
  //       return "lib/assets/images/character/tamagotchi2.png";
  //     case TamagotchiStage.BABY:
  //       return "lib/assets/images/character/tamagotchi2.png";
  //     case TamagotchiStage.TEEN:
  //       return "lib/assets/images/character/tamagotchi2.png";
  //     case TamagotchiStage.ADULT:
  //       return "lib/assets/images/character/tamagotchi2.png";
  //   }
  // }


  void setFriendly(double friendlyValue) {
    if (friendlyValue < 0) {
      _friendlyValue = 0;
    } else if (friendlyValue > 1) {
      _friendlyValue = 1;
    } else {
      _friendlyValue = friendlyValue;
    }

    notifyListeners();
  }

  void setHunger(int hunger) {
    if (hunger < 0) {
      _hunger = 0;
    } else if (hunger > 100) {
      _hunger = 100;
    } else {
      _hunger = hunger;
    }

    notifyListeners();
  }

  void setThirst(int thirst) {
    if (thirst < 0) {
      _thirst = 0;
    } else if (thirst > 100) {
      _thirst = 100;
    } else {
      _thirst = thirst;
    }

    notifyListeners();
  }

  void setHappiness(int happiness) {
    if (happiness < 0) {
      _happiness = 0;
    } else if (happiness > 100) {
      _happiness = 100;
    } else {
      _happiness = happiness;
    }

    notifyListeners();
  }

  void grow() {
    _age += 1;
    if (_currentStage == TamagotchiStage.EGG) {
      if (_age > 10) {
        _currentStage = TamagotchiStage.BABY;
      }
    } else if (_currentStage == TamagotchiStage.BABY) {
      if (_age > 20 && _friendlyValue > 0.5) {
        _currentStage = TamagotchiStage.TEEN;
      }
    } else if (_currentStage == TamagotchiStage.TEEN) {
      if (_age > 30 && _friendlyValue > 0.8) {
        _currentStage = TamagotchiStage.ADULT;
      }
    }

    notifyListeners();
    save();
  }

  void decreaseFriendly() {
    setFriendly(friendlyValue - 0.1);
  }

  void increaseFriendly() {
    setFriendly(friendlyValue + 0.1);
  }

  void defaultPenalty() {
    setHunger(hunger - 1);
    setThirst(thirst - 1);
    setHappiness(happiness - 1);
  }

  void afkPenalty() {
    setHunger(hunger - 5);
    setThirst(thirst - 5);
    setHappiness(happiness - 5);
  }

  void feed() {
    setHunger(hunger + 15);
  }

  void water() {
    setThirst(thirst + 15);
  }

  void hungry() {
    setHunger(hunger - 15);
  }

  void happy() {
    setHappiness(happiness + 15);
  }

  void unhappiness() {
    setHappiness(happiness - 5);
  }

  void care() {
    setHappiness(happiness + 15);
    setHunger(hunger + 5);
    setThirst(thirst + 5);
  }

  void sick() {
    setHunger(hunger - 10);
    setThirst(thirst - 10);
    setHappiness(happiness - 10);
  }

  void thirsty() {
    setThirst(thirst - 10);
  }

  void poop() {
    setHappiness(happiness - 10);
  }

  void clean() {
    setHappiness(happiness + 10);
    setHunger(hunger - 5);
    setThirst(thirst - 5);
  }

  void play() {
    setHappiness(happiness + 10);
  }
}