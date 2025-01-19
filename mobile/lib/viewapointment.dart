import 'package:flutter/material.dart';

class ViewAppointmentPage extends StatelessWidget {
  const ViewAppointmentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> appointments = [
      {
        "date": "12/12/2024",
        "doctor": "Dr. Andi Susanto",
        "specialty": "Cardiologist",
      },
      {
        "date": "15/12/2024",
        "doctor": "Dr. Clara Ayu",
        "specialty": "Dermatologist",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      appBar: AppBar(
        title: const Text(
          "Your Appointments",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color(0xFFFFEBEE),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            final appointment = appointments[index];
            return _buildAppointmentCard(
              date: appointment["date"]!,
              doctor: appointment["doctor"]!,
              specialty: appointment["specialty"]!,
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppointmentCard({
    required String date,
    required String doctor,
    required String specialty,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Ikon Tanggal
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFFFEBEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.calendar_today,
                color: Color(0xFFD4696E),
                size: 30,
              ),
            ),
            const SizedBox(width: 16),
            // Detail Janji Temu
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    doctor,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
