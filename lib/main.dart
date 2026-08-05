import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const DSFunLearningApp());
}

class DSFunLearningApp extends StatelessWidget {
  const DSFunLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DS Fun Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A6CF7),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7FF),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Color(0xFF4A6CF7),
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
