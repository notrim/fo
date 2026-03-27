import 'package:flutter/material.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ZenMomentApp());
}

class ZenMomentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '禅心一刻',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        fontFamily: 'NotoSerifSC',
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 18, height: 1.6),
          bodyMedium: TextStyle(fontSize: 16, height: 1.6),
        ),
      ),
      home: HomePage(),
    );
  }
}