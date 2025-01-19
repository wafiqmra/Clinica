import 'package:flutter/material.dart';
import 'home.dart';
import 'history.dart';
import 'appointment.dart';
import 'settings.dart'; // Import file Settings

class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0; // Index halaman saat ini
  late PageController _pageController; // Controller untuk PageView

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Cek argument untuk menentukan halaman awal
    final arguments = ModalRoute.of(context)?.settings.arguments as int?;
    if (arguments != null && arguments != _currentIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _currentIndex = arguments;
          _pageController.jumpToPage(_currentIndex);
        });
      });
    }
  }

  @override
  void dispose() {
    _pageController
        .dispose(); // Membersihkan controller saat widget dihancurkan
    super.dispose();
  }

  // Daftar halaman (PageView)
  final List<Widget> _pages = [
    HomePage(),
    HistoryPage(),
    AppointmentPage(),
    SettingsPage(), // Tambahkan SettingsPage
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics:
            const NeverScrollableScrollPhysics(), // Navigasi hanya melalui BottomNavigationBar
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFFD4696E), // Warna saat dipilih
        unselectedItemColor: Colors.grey, // Warna saat tidak dipilih
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Perbarui indeks halaman
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300), // Animasi geser
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
