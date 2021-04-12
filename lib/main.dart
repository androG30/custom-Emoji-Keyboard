import 'package:emoji_keyboard_app/screen/home_screen.dart';
import 'package:flutter/material.dart';

import 'helper/constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Keyboard Demo',
      theme: ThemeData(
        primarySwatch: accentColor,
      ),
      home: HomeScreen(title: 'Emoji Keyboard'),
    );
  }
}


