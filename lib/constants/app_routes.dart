import 'package:flutter/material.dart';

import '../ui/home/home.dart';
import '../ui/settings/settings.dart';
import '../ui/sudoku/sudoku.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (_) => const Home(),
    Routes.settings: (_) => const Settings(),
    Routes.game: (_) => const SudokuGame(),
  };
}
