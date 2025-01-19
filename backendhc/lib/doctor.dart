import 'package:backendhc/model/doctormodel.dart';
import 'package:backendhc/service/doctorservice.dart';
import 'package:flutter/material.dart';

import 'editdoctor.dart'; // Tambahkan import untuk halaman edit doctor
import 'adddoctor.dart'; // Halaman untuk menambah doctor

class DoctorManagementScreen extends StatefulWidget {
  const DoctorManagementScreen({super.key});

  @override
  _DoctorManagementScreenState createState() => _DoctorManagementScreenState();
}

class _DoctorManagementScreenState extends State<DoctorManagementScreen> {
  late DoctorService _doctorService;
  List<Doctor> _doctors = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService(baseUrl: 'http://192.168.117.131:5000');
    _fetchDoctors();
  }

  Future<void> _fetchDoctors() async {
    try {
      final doctors = await _doctorService.fetchDoctors();
      setState(() {
        _doctors = doctors;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load doctors: $e';
        _isLoading = false;
      });
    }
  }

  // Fungsi untuk menghapus dokter
  Future<void> _deleteDoctor(int doctorId) async {
    try {
      await _doctorService.deleteDoctor(doctorId);
      _fetchDoctors(); // Refresh daftar dokter setelah penghapusan
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to delete doctor: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Management'),
        centerTitle: true,
        backgroundColor: const Color(0xFFEC818D),
      ),
      body: Container(
        color: const Color(0xFFFFF5F5),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage.isNotEmpty
                ? Center(
                    child: Text(
                      _errorMessage,
                      style: const TextStyle(color: Color(0xFFDA6976)),
                    ),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Total Doctors: ${_doctors.length}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFDA6976),
                          ),
                        ),
                      ),
                      Expanded(
                        child: _doctors.isEmpty
                            ? const Center(
                                child: Text(
                                  'No doctors available.',
                                  style: TextStyle(color: Color(0xFFDA6976)),
                                ),
                              )
                            : ListView.builder(
                                padding: const EdgeInsets.all(16.0),
                                itemCount: _doctors.length,
                                itemBuilder: (context, index) {
                                  final doctor = _doctors[index];
                                  return Card(
                                    color: const Color(0xFFF7BCC2),
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: const Color(0xFFDA6976),
                                        child: Text(
                                          doctor.name[0].toUpperCase(),
                                          style: const TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      title: Text(
                                        doctor.name,
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      subtitle: Text(
                                        'Specialization: ${doctor.specialization}\nContact: ${doctor.contact}',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.white),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditDoctorScreen(doctor: doctor),
                                                ),
                                              ).then((_) => _fetchDoctors());
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.white),
                                            onPressed: () {
                                              _deleteDoctor(doctor.id);
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Navigasi ke halaman AddDoctorScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const AddDoctorScreen()),
                            ).then((_) => _fetchDoctors()); // Refresh daftar dokter setelah menambah
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFEC818D), // Warna tombol
                          ),
                          child: const Text(
                            'Add Doctor',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
