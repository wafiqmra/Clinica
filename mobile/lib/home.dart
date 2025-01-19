import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE), // Background pink muda
      body: Column(
        children: [
          // Bagian atas dengan gambar CLINICA
          Container(
            color: const Color(0xFFFFEBEE),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'image/clinica2.png', // Gambar logo CLINICA
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

          // Box putih (Isi utama)
          Expanded(
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
                    const SizedBox(height: 16),
                    const Text(
                      "👋 Hi!!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Medical History Card
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke History melalui NavigationPage
                        Navigator.pushNamed(
                          context,
                          '/navigation',
                          arguments: 1, // Indeks tab untuk History
                        );
                      },
                      child: Card(
                        color: const Color(0xFFFFF3F4), // Warna pink muda
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'image/history.png', // Gambar Medical History
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                "Medical History",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Appointment Card
                    GestureDetector(
                      onTap: () {
                        // Navigasi ke Appointment melalui NavigationPage
                        Navigator.pushNamed(
                          context,
                          '/navigation',
                          arguments: 2, // Indeks tab untuk Appointment
                        );
                      },
                      child: Card(
                        color: const Color(0xFFFFF3F4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 16.0),
                          child: Row(
                            children: [
                              Image.asset(
                                'image/appointment.png', // Gambar Appointment
                                width: 50,
                                height: 50,
                              ),
                              const SizedBox(width: 16),
                              const Text(
                                "Appointment",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
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
}
