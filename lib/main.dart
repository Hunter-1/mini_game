import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:mini_game/screens/main_menu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  runApp(MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const MainMenu()));
}
