import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:le_petit_davinci/app.dart';

void main() {
  runApp(DevicePreview(enabled: kDebugMode, builder: (context) => App()));
  //runApp(const App());
}
