import 'package:flutter/material.dart';
import 'package:backendhc/model/doctormodel.dart';
import 'package:backendhc/service/doctorservice.dart';

class EditDoctorScreen extends StatefulWidget {
  final Doctor doctor;

  const EditDoctorScreen({super.key, required this.doctor});

  @override
  _EditDoctorScreenState createState() => _EditDoctorScreenState();
}

class _EditDoctorScreenState extends State<EditDoctorScreen> {
  late TextEditingController _nameController;
  late TextEditingController _specializationController;
  late TextEditingController _contactController;
  late DoctorService _doctorService;

  @override
  void initState() {
    super.initState();
    _doctorService = DoctorService(baseUrl: 'http://192.168.117.131:5000');
    _nameController = TextEditingController(text: widget.doctor.name);
    _specializationController = TextEditingController(text: widget.doctor.specialization);
    _contactController = TextEditingController(text: widget.doctor.contact);
  }

  Future<void> _updateDoctor() async {
    final updatedDoctor = Doctor(
      id: widget.doctor.id,
      name: _nameController.text,
      specialization: _specializationController.text,
      contact: _contactController.text,
      availability: '',
    );

    try {
      await _doctorService.updateDoctor(updatedDoctor);
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update doctor: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Doctor'),
        backgroundColor: const Color(0xFFEC818D),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
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
              onPressed: _updateDoctor,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDA6976),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
