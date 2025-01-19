import 'package:flutter/material.dart';
import 'package:mobile/appointment.dart';
import 'package:mobile/history.dart';
import 'package:mobile/home.dart';
import 'package:mobile/signup.dart';
import 'package:mobile/signin.dart';
import 'package:mobile/navigation.dart';
import 'package:mobile/viewapointment.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Halaman awal adalah MainPage
      routes: {
        '/': (context) => const MainPage(), // Halaman utama
        '/signup': (context) => SignUpPage(), // Halaman Sign Up
        '/signin': (context) => SignInPage(), // Halaman Sign In
        '/navigation': (context) =>
            const NavigationPage(), // Halaman dengan navigasi bawah
        '/home': (context) => HomePage(), // Halaman Home
        '/history': (context) => HistoryPage(), // Halaman History
        '/appointment': (context) =>
            const AppointmentPage(), // Halaman Appointment
        '/viewappointment': (context) => const ViewAppointmentPage()
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFFFEBEE), // Warna latar belakang pink muda
      body: Stack(
        children: [
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
              const Spacer(),
              // Kotak Putih di Bagian Bawah
              Container(
                width: double.infinity,
                height: 280, // Tinggi kotak putih diperbesar
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
          // Gambar Dokter
          Positioned(
            bottom: 1,
            left: 0,
            right: 0,
            child: Image.asset(
              'image/doctor.png', // Gambar dokter
              width: 350,
              height: 400,
            ),
          ),
          // Tombol di Tengah
          Positioned(
            top: 300,
            left: 16,
            right: 16,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/signup'); // Pindah ke Halaman Sign Up
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD4696E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, '/signin'); // Pindah ke Halaman Sign In
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8BBD0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 18, color: Colors.black),
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
