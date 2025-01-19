import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HistoryPage extends StatelessWidget {
  final double boxHeight;

  HistoryPage({Key? key, this.boxHeight = 0.7}) : super(key: key);

  Future<List<Map<String, String>>> _fetchHistoryData() async {
    final response = await http.get(
      Uri.parse('https://a2222f72de47c6.lhr.life/api/appointments'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map<Map<String, String>>((appointment) {
        return {
          "date": appointment["appointment_date"]
              .split(' ')[0], // Ambil tanggal saja
          "doctor": appointment["doctor_id"] == 1
              ? "Dr. Andi Susanto"
              : appointment["doctor_id"] == 2
                  ? "Dr. Budi Wijaya"
                  : "Dr. Clara Ayu",
          "specialization": appointment["doctor_id"] == 1
              ? "Cardiologist"
              : appointment["doctor_id"] == 2
                  ? "Pediatrician"
                  : "Dermatologist",
        };
      }).toList();
    } else {
      throw Exception('Failed to fetch history data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Background pink muda
      body: Column(
        children: [
          // Header dengan logo dan avatar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'image/clinica2.png', // Logo CLINICA
                  width: 200,
                ),
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('image/profile.png'), // Avatar pengguna
                  radius: 25,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Box putih dengan konten utama
          Expanded(
            flex: (boxHeight * 10).toInt(), // Kontrol tinggi box putih
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white, // Box putih
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul di dalam box putih
                    const Text(
                      "Medical History",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // FutureBuilder untuk memuat data dari API
                    Expanded(
                      child: FutureBuilder<List<Map<String, String>>>(
                        future: _fetchHistoryData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Failed to load history: ${snapshot.error}',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text(
                                'No medical history available.',
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }

                          final historyData = snapshot.data!;
                          return ListView.builder(
                            itemCount: historyData.length,
                            itemBuilder: (context, index) {
                              final history = historyData[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _buildHistoryCard(
                                  date: history["date"]!,
                                  doctor: history["doctor"]!,
                                  specialization: history["specialization"]!,
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard({
    required String date,
    required String doctor,
    required String specialization,
  }) {
    return Card(
      color: const Color(0xFFFFF3F4), // Warna pink muda
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today,
              color: Colors.pink,
              size: 30,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  doctor,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  specialization,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
