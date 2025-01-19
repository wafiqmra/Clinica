import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:backendhc/model/appoinmentmodel.dart';
import 'package:backendhc/service/appointmentservice.dart';
import 'package:backendhc/service/doctorservice.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  _AdminHomeScreenState createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  late AppointmentService _appointmentService;
  late DoctorService _doctorService;

  List<Appointment> _appointments = [];
  int _appointmentsToday = 0;
  int _totalDoctors = 0;
  Map<String, int> _appointmentsByDate = {};

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _appointmentService = AppointmentService(baseUrl: 'http://192.168.117.131:5000');
    _doctorService = DoctorService(baseUrl: 'http://192.168.117.131:5000');
    _fetchAppointments();
    _fetchDoctors();
  }

  Future<void> _fetchAppointments() async {
    try {
      final appointments = await _appointmentService.fetchAppointments();
      final today = DateTime.now();

      int appointmentsToday = appointments.where((appointment) {
        final appointmentDate = DateFormat('EEE, dd MMM yyyy HH:mm:ss z').parse(appointment.appointmentDate);
        return appointmentDate.year == today.year &&
            appointmentDate.month == today.month &&
            appointmentDate.day == today.day;
      }).length;

      Map<String, int> appointmentsByDate = {};
      for (var appointment in appointments) {
        final appointmentDate = DateFormat('EEE, dd MMM yyyy HH:mm:ss z').parse(appointment.appointmentDate);
        final formattedDate = DateFormat('yyyy-MM-dd').format(appointmentDate);
        appointmentsByDate[formattedDate] = (appointmentsByDate[formattedDate] ?? 0) + 1;
      }

      setState(() {
        _appointments = appointments;
        _appointmentsToday = appointmentsToday;
        _appointmentsByDate = appointmentsByDate;
      });
    } catch (e) {
      print('Error fetching appointments: $e');
      setState(() {
        _appointmentsToday = 0;
      });
    }
  }

  Future<void> _fetchDoctors() async {
    try {
      final doctors = await _doctorService.fetchDoctors();
      setState(() {
        _totalDoctors = doctors.length;
      });
    } catch (e) {
      print('Error fetching doctors: $e');
      setState(() {
        _totalDoctors = 0;
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() {
    // Log out and navigate to login screen
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    final dates = _appointmentsByDate.keys.toList();
    final values = _appointmentsByDate.values.toList();

    List<Widget> pages = [
      Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          centerTitle: true,
          backgroundColor: const Color(0xFFDA6976),  // DA6976 (Dark Rose)
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: _logout,
            ),
          ],
        ),
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Welcome, Admin',
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFFEC818D),  // EC818D (Soft Red)
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StatisticCard(
                    title: 'Doctors',
                    value: _totalDoctors.toString(),
                    icon: Icons.local_hospital,
                    color: const Color(0xFFF3A7B0),  // F7BCC2 (Light Pink)
                  ),
                  StatisticCard(
                    title: 'Today\'s Appointments',
                    value: _appointmentsToday.toString(),
                    icon: Icons.calendar_today,
                    color: const Color(0xFFF3A7B0),  // F3A7B0 (Soft Pink)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFFFFF5F5),  // FFF5F5 (Very Light Pink)
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 4, spreadRadius: 2),
                  ],
                ),
                child: BarChart(
                  BarChartData(
                    gridData: const FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            if (value < 0 || value >= dates.length) return const SizedBox.shrink();
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Text(
                                  dates[value.toInt()],
                                  style: const TextStyle(fontSize: 10, color: Color(0xFFDA6976)),  // DA6976 (Dark Rose)
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(show: true),
                    barGroups: List.generate(dates.length, (index) {
                      return BarChartGroupData(
                        x: index,
                        barRods: [
                          BarChartRodData(toY: values[index].toDouble(), color: const Color(0xFFEC818D)),  // EC818D (Soft Red)
                        ],
                      );
                    }),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  MenuCard(
                    title: 'Doctor Management',
                    icon: Icons.person,
                    onTap: () {
                      Navigator.pushNamed(context, '/doctor-management');
                    },
                    color: const Color(0xFFDA6976),  // F7BCC2 (Light Pink)
                  ),
                  MenuCard(
                    title: 'Appointments',
                    icon: Icons.assignment,
                    onTap: () {
                      Navigator.pushNamed(context, '/appointment-management');
                    },
                    color: const Color(0xFFDA6976),  // F3A7B0 (Soft Pink)
                  ),
                  MenuCard(
                    title: 'Notifications',
                    icon: Icons.notifications,
                    onTap: () {
                      Navigator.pushNamed(context, '/notifications');
                    },
                    color: const Color(0xFFDA6976),  // DA6976 (Dark Rose)
                  ),
                  MenuCard(
                    title: 'User Management',
                    icon: Icons.people,
                    onTap: () {
                      Navigator.pushNamed(context, '/user-management');
                    },
                    color: const Color(0xFFDA6976),  // EC818D (Soft Red)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Scaffold(
        appBar: AppBar(
          title: const Text('Tentang CLINICA'),
          centerTitle: true,
          backgroundColor: const Color(0xFFDA6976),  // DA6976 (Dark Rose)
        ),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Selamat datang di CLINICA!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFFEC818D)),  // EC818D (Soft Red)
              ),
              SizedBox(height: 16),
              Text(
                'CLINICA bukan hanya sekadar aplikasi, melainkan asisten pribadi digital Anda '
                'untuk menjalin komunikasi dengan dokter dengan cara yang lebih mudah, cepat, '
                'dan tentunya lebih menyenangkan. Mulai dari mengatur jadwal janji temu hingga '
                'mendapatkan pengingat penting, semuanya ada di sini untuk memberikan pengalaman '
                'yang nyaman dan efisien bagi Anda!',
                style: TextStyle(fontSize: 16, color: Color(0xFFDA6976)),  // DA6976 (Dark Rose)
              ),
              SizedBox(height: 32),
              Text(
                'Siapa Dibalik CLINICA?',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFEC818D)),  // EC818D (Soft Red)
              ),
              SizedBox(height: 8),
              Text('1. 152022110 - Wafiq Mariatul Azizah'),
              Text('2. 152022126 - Crystal Fandya Putri'),
              SizedBox(height: 16),
              Text(
                'Kami berkomitmen untuk memberikan yang terbaik bagi Anda. Terima kasih telah '
                'memilih CLINICA untuk perjalanan kesehatan Anda!',
                style: TextStyle(fontSize: 16, color: Color(0xFFDA6976)),  // DA6976 (Dark Rose)
              ),
            ],
          ),
        ),
      ),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
        selectedItemColor: const Color(0xFFDA6976),  // DA6976 (Dark Rose)
        unselectedItemColor: const Color(0xFFF7BCC2),  // F7BCC2 (Light Pink)
      ),
    );
  }
}

class StatisticCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatisticCard({super.key, required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.white),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 22, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}

class MenuCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  final Color color;

  const MenuCard({super.key, required this.title, required this.icon, required this.onTap, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 30, color: Colors.white),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
