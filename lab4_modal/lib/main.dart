import 'package:flutter/material.dart';
import 'widgets/sample_modal.dart';

void main() {
  runApp(const ModalApp());
}

class ModalApp extends StatelessWidget {
  const ModalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lab 4 - Modal and Scrolling',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E5E3A)),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const ModalHomeScreen(),
    );
  }
}

class ModalHomeScreen extends StatelessWidget {
  const ModalHomeScreen({super.key});

  void _openModal(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const SampleModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sample Modal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFF1E5E3A),
        elevation: 2,
      ),
      body: Center(
        child: SizedBox(
          width: 220.0,
          height: 48.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E5E3A),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () => _openModal(context),
            child: const Text(
              'OPEN MODAL',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}