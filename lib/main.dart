import 'package:ask_ai/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AskAI());
}

class AskAI extends StatelessWidget {
  const AskAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ask AI",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        primarySwatch: Colors.teal,
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          centerTitle: true,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
