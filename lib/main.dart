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
    runApp(const App());
  });
}
