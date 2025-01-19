import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifikasi'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Halaman Notifikasi',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
