import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:suitmedia_intern_test/style/theme.dart';
import 'package:suitmedia_intern_test/ui/FirstScreen.dart';

void main() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: FirstScreen()
    );
  }
}