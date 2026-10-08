import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const TroubleFixApp());
}

class TroubleFixApp extends StatelessWidget {
  const TroubleFixApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TroubleFix',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
        ),
      ),
      home: const SplashPage(),
    );
  }
}