import 'Tamagotchi.dart';

class TamagotchiProvider {
  static final TamagotchiProvider _instance = TamagotchiProvider._internal();
  late Tamagotchi _tamagotchi;

  factory TamagotchiProvider() {
    return _instance;
  }

  TamagotchiProvider._internal() {
    _tamagotchi = Tamagotchi();
    _tamagotchi.load();
  }

  Tamagotchi get tamagotchi => _tamagotchi;
}