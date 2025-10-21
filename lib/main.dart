import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:le_petit_davinci/app.dart';
import 'package:le_petit_davinci/data/repositories/authentication_repository.dart';
import 'package:le_petit_davinci/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  //* Initialize Supabase
  await Supabase.initialize(
    url: 'https://vncsfhiujnoymnzsjqvo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZuY3NmaGl1am5veW1uenNqcXZvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk3NDUyMzksImV4cCI6MjA3NTMyMTIzOX0.D5d5n_EckjxPV87k2z8YrCvB5P4GpqKdzi4HyUnYwmg',
  );
  
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

  //* init local storage
  final storageService = Get.put(StorageService());
  await storageService.init();

  Get.put(AuthenticationRepository());

  runApp(const App());
}
