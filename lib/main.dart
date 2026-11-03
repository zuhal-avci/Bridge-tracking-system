import 'package:flutter/material.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(const KopruApp());
}

class KopruApp extends StatelessWidget {
  const KopruApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Köprü Bilgi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const SplashScreen(),
    );
  }
}
