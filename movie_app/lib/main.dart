import 'package:flutter/material.dart';
import 'package:movie_app/home.screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const String appTitle = 'Movie App';
    return const MaterialApp(
      title: appTitle,
      home:  HomeScreen(),
    );
  }
}
