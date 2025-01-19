import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEBEE), // Warna latar belakang sesuai desain
      body: Stack(
        children: [
          // Bagian Utama
          Column(
            children: [
              // Bagian Logo di Sebelah Kiri
              Padding(
                padding: const EdgeInsets.only(top: 38.0, left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'image/clinica2.png', // Gambar logo
                    width: 200,
                  ),
                ),
              ),
              // Bagian Judul
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Image.asset(
                      'image/welcome.png', // Gambar teks "WELCOME TO CLINICA"
                      width: 300,
                    ),
                  ],
                ),
              ),
              Spacer(),
              // Kotak Putih di Bagian Bawah
              Container(
                width: double.infinity,
                height: 280, // Tinggi kotak putih diperbesar
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
              ),
            ],
          ),
          // Gambar Dokter (di atas kotak putih, posisinya sedikit turun)
          Positioned(
            bottom: 1, // Sedikit diturunkan
            left: 0,
            right: 0,
            child: Image.asset(
              'image/doctor.png', // Gambar dokter
              width: 350, // Gambar diperbesar
              height: 400,
            ),
          ),
          // Tombol di Tengah (dengan posisi yang bisa diatur)
          Positioned(
            top: 300, // Atur posisi vertikal tombol
            left: 16, // Atur posisi horizontal tombol
            right: 16,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFD4696E), // Warna tombol Sign Up
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 20), // Jarak antar tombol
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF8BBD0), // Warna tombol Sign In
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
