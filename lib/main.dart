import 'package:flutter/material.dart';
import 'package:stagged_animation/screen/home_page.dart';
import 'package:stagged_animation/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'splash_screen',
      routes: {
        '/': (context) => const HomePage(),
        'splash_screen': (context) => const SplashScreen(),
      },
    );
  }
}
