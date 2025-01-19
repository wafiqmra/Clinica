import 'dart:convert';
import 'package:backendhc/model/doctormodel.dart';
import 'package:http/http.dart' as http;

class DoctorService {
  final String baseUrl;

  DoctorService({required this.baseUrl});

  // Fungsi untuk mengambil data dokter
  Future<List<Doctor>> fetchDoctors() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/doctors'));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Doctor.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load doctors');
      }
    } catch (e) {
      throw Exception('Error occurred while fetching data: $e');
    }
  }

  // Fungsi untuk memperbarui data dokter
  Future<void> updateDoctor(Doctor doctor) async {
    final url = Uri.parse('$baseUrl/api/doctors/${doctor.id}'); // Endpoint dengan ID
    print('Updating doctor at: $url');
    print('Payload: ${jsonEncode(doctor.toJson())}');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(doctor.toJson()),
    );

    if (response.statusCode == 200) {
      print('Doctor updated successfully!');
    } else {
      print('Failed to update doctor: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to update doctor.');
    }
  }

  // Fungsi untuk menambah data dokter
  Future<void> addDoctor(Doctor doctor) async {
    final url = Uri.parse('$baseUrl/api/doctors'); // Endpoint untuk menambah data dokter
    print('Adding doctor at: $url');
    print('Payload: ${jsonEncode(doctor.toJson())}');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(doctor.toJson()),
    );

    if (response.statusCode == 201) {
      print('Doctor added successfully!');
    } else {
      print('Failed to add doctor: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to add doctor.');
    }
  }

  // Fungsi untuk menghapus data dokter
  Future<void> deleteDoctor(int doctorId) async {
    final url = Uri.parse('$baseUrl/api/doctors/$doctorId'); // Endpoint untuk menghapus dokter berdasarkan ID
    print('Deleting doctor at: $url');

    final response = await http.delete(
      url,
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print('Doctor deleted successfully!');
    } else {
      print('Failed to delete doctor: ${response.statusCode} - ${response.body}');
      throw Exception('Failed to delete doctor.');
    }
  }
}
