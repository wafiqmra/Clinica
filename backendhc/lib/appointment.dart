import 'package:backendhc/model/appoinmentmodel.dart';
import 'package:backendhc/service/appointmentservice.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import this package for date formatting

class AppointmentManagementScreen extends StatefulWidget {
  const AppointmentManagementScreen({super.key});

  @override
  _AppointmentManagementScreenState createState() =>
      _AppointmentManagementScreenState();
}

class _AppointmentManagementScreenState
    extends State<AppointmentManagementScreen> {
  late AppointmentService _appointmentService;
  List<Appointment> _appointments = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _appointmentService = AppointmentService(baseUrl: 'http://192.168.117.131:5000');
    _fetchAppointments();
  }

  Future<void> _fetchAppointments() async {
    try {
      final appointments = await _appointmentService.fetchAppointments();
      setState(() {
        _appointments = appointments; // Menampilkan semua appointment
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load appointments: $e';
        _isLoading = false;
      });
    }
  }

  // Fungsi untuk menghitung jumlah appointment hari ini
  int _countTodayAppointments(List<Appointment> appointments) {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    return appointments.where((appointment) {
      try {
        final appointmentDate = DateFormat('EEE, dd MMM yyyy HH:mm:ss z')
            .parse(appointment.appointmentDate);
        final formattedAppointmentDate =
            DateFormat('yyyy-MM-dd').format(appointmentDate);
        return formattedAppointmentDate == today;
      } catch (e) {
        return false;
      }
    }).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Management'),
        centerTitle: true,
        backgroundColor: const Color(0xFFEC818D), // Warna AppBar
      ),
      body: Container(
        color: const Color(0xFFFFF5F5), // Warna background
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Color(0xFFDA6976)), // Warna teks error
                    ),
                  )
                : Column(
                    children: [
                      // Menampilkan jumlah appointment hari ini
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Appointments Today: ${_countTodayAppointments(_appointments)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDA6976), // Warna teks judul
                          ),
                        ),
                      ),
                      // List of appointments
                      Expanded(
                        child: _appointments.isEmpty
                            ? const Center(
                                child: Text(
                                  'No appointments available.',
                                  style: TextStyle(color: Color(0xFFDA6976)), // Warna teks kosong
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16.0),
                                itemCount: _appointments.length,
                                itemBuilder: (context, index) {
                                  final appointment = _appointments[index];
                                  return Card(
                                    color: const Color(0xFFF7BCC2), // Warna card
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color(0xFFDA6976), // Warna avatar
                                        child: Text(
                                          appointment.patientName[0].toUpperCase(),
                                          style: const TextStyle(color: Colors.white), // Warna teks avatar
                                        ),
                                      ),
                                      title: Text(
                                        appointment.patientName,
                                        style: const TextStyle(color: Colors.white), // Warna teks nama
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Doctor ID: ${appointment.doctorId}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Contact: ${appointment.patientContact}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Date: ${appointment.appointmentDate}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Status: ${appointment.status}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Reason: ${appointment.reasonForVisit}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            'Notes: ${appointment.notes}',
                                            style: const TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.edit, color: Colors.white), // Warna ikon edit
                                        onPressed: () {
                                          // Navigate to the edit appointment page
                                        },
                                      ),
                                      onTap: () {
                                        // Navigate to the appointment detail page
                                      },
                                    ),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
