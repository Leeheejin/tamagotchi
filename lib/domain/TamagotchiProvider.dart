import 'Tamagotchi.dart';

class TamagotchiProvider {
  static final TamagotchiProvider instance = TamagotchiProvider._internal();
  late Tamagotchi _tamagotchi;

  TamagotchiProvider._internal() {
    _tamagotchi = Tamagotchi();
    _tamagotchi.load();
  }

  Tamagotchi get tamagotchi => _tamagotchi;
}