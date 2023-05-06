import '../constants/game_tags.dart';

GameSettings gameSettings = GameSettings();

class GameSettings {
  int dificult = 40;
  int cluesLimits = 10;
  int errorLimit = -1; // -1 = unlimited

  String patternName = gameTags.gcRandom;

  void reset() {
    dificult = 40;
    patternName = gameTags.gcRandom;
  }

  String getDificult(value) {
    switch (value) {
      case 40:
        return gameTags.gcEasy;
      case 32:
        return gameTags.gcMedium;
      case 24:
        return gameTags.gcHard;
      default:
        return gameTags.gcUnknown;
    }
  }
}
