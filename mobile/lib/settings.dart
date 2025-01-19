import 'package:flutter/material.dart';
import 'package:mobile/profile.dart'; // Import halaman Profile

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

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

          // Konten utama
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
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
                    const Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Informasi Akun
                    _buildSettingOption(
                      context,
                      title: "Account Information",
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfilePage()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Logout
                    _buildSettingOption(
                      context,
                      title: "Logout",
                      icon: Icons.logout,
                      onTap: () {
                        // Navigasi ke halaman login
                        Navigator.pushReplacementNamed(context, '/signin');
                      },
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

  Widget _buildSettingOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: const Color(0xFFF8F8F8), // Warna abu muda
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFFD4696E), size: 28),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
