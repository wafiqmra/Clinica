import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistik'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Halaman Statistik',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}