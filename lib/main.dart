import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:le_petit_davinci/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //? Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set status bar color to transparent
      systemNavigationBarColor:
          Colors.transparent, // Set navigation bar color to transparent
      systemNavigationBarIconBrightness:
          Brightness.dark, // Set navigation bar icons to dark
    ),
  );
  // runApp(
  //   DevicePreview(
  //     enabled: true, // Set to false in production
  //     builder: (context) => const App(),
  //   ),
  // );
  runApp(const App());
}
