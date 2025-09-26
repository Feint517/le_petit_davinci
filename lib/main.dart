import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/app.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/services/storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //? Lock orientation to portrait only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor:
          Colors.transparent, //? Set status bar color to transparent
      systemNavigationBarColor:
          Colors.transparent, //? Set navigation bar color to transparent
      systemNavigationBarIconBrightness:
          Brightness.dark, //? Set navigation bar icons to dark
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  //! this line ensures that the firebase initialization finishes first, then initialize the design widgets

  //* init local storage
  final storageService = Get.put(StorageService());
  await storageService.init();


  Get.put(AuthenticationRepository());

  runApp(const App());
}
