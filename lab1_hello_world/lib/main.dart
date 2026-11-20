import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 1 - Hello World',
      home: Scaffold(
        backgroundColor: Color(0xFF76BAF6),
        body: Center(
          child: Text(
            'Hello World!',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F3B66),
            ),
          ),
        ),
      ),
    );
  }
}