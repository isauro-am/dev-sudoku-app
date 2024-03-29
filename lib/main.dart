import 'package:device_preview/device_preview.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resize/resize.dart';

import 'constants/app_routes.dart';
import 'constants/routes.dart';
import 'ui/sudoku/bloc/sudoku_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      builder: (_) => const MyApp(),
      // enabled: !kReleaseMode, // Enable DevicePreview only in debug mode
      enabled: false, // Enable DevicePreview only in debug mode
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Resize(
        allowtextScaling: true,
        builder: () {
          return BlocProvider(
            create: (context) => SudokuBloc(),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: MyCustomScrollBehavior(),
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              initialRoute: Routes.home,
              routes: appRoutes,
            ),
          );
        });
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
