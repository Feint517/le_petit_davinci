import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:le_petit_davinci/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //? Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    // runApp(
    //   DevicePreview(
    //     enabled: true, // Set to false in production
    //     builder: (context) => const App(),
    //   ),
    // );
    runApp(const App());
  });
}
