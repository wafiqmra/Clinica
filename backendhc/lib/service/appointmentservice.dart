import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:backendhc/model/appoinmentmodel.dart';

class AppointmentService {
  final String baseUrl;

  AppointmentService({required this.baseUrl});

  Future<List<Appointment>> fetchAppointments() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/appointments'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((item) => Appointment.fromJson(item)).toList(); // Parsing data
      } else {
        throw Exception('Failed to load appointments');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
