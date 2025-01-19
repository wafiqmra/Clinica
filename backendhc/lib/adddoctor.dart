import 'package:flutter/material.dart';
import 'package:backendhc/model/doctormodel.dart';
import 'package:backendhc/service/doctorservice.dart';

class AddDoctorScreen extends StatefulWidget {
  const AddDoctorScreen({super.key});

  @override
  _AddDoctorScreenState createState() => _AddDoctorScreenState();
}

class _AddDoctorScreenState extends State<AddDoctorScreen> {
  final _nameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _contactController = TextEditingController();
  final _doctorService = DoctorService(baseUrl: 'http://192.168.117.131:5000');

  Future<void> _addDoctor() async {
    final doctor = Doctor(
      id: 0, // ID akan di-generate oleh backend
      name: _nameController.text,
      specialization: _specializationController.text,
      contact: _contactController.text, availability: '',
    );
    
    try {
      await _doctorService.addDoctor(doctor);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add doctor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Doctor'),
        backgroundColor: const Color(0xFFEC818D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Doctor Name'),
            ),
            TextField(
              controller: _specializationController,
              decoration: const InputDecoration(labelText: 'Specialization'),
            ),
            TextField(
              controller: _contactController,
              decoration: const InputDecoration(labelText: 'Contact'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDoctor,
              child: const Text('Add Doctor'),
            ),
          ],
        ),
      ),
    );
  }
}
