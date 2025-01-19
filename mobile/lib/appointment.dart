import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({Key? key}) : super(key: key);

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime? selectedDate;
  String? selectedDoctor;

  final List<String> doctors = [
    "Dr. Andi Susanto - Cardiologist",
    "Dr. Budi Wijaya - Pediatrician",
    "Dr. Clara Ayu - Dermatologist",
  ];

  final Map<String, int> doctorIdMapping = {
    "Dr. Andi Susanto - Cardiologist": 1,
    "Dr. Budi Wijaya - Pediatrician": 2,
    "Dr. Clara Ayu - Dermatologist": 3,
  };

  Future<void> _submitAppointment() async {
    if (selectedDate == null || selectedDoctor == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select both date and doctor!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String appointmentDate =
        "${selectedDate!.year}-${selectedDate!.month.toString().padLeft(2, '0')}-${selectedDate!.day.toString().padLeft(2, '0')}";

    final int? doctorId = doctorIdMapping[selectedDoctor!];

    if (doctorId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid doctor selection!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Data tambahan
    const String patientName =
        "Crystal Fandya Putri"; // Ganti dengan nama pasien
    const String patientContact = "081234567890"; // Ganti dengan kontak pasien
    const String reasonForVisit =
        "General Consultation"; // Ganti sesuai kebutuhan
    const String notes = "No specific notes"; // Ganti jika ada catatan tambahan
    const String status = "Scheduled"; // Default status untuk janji temu

    final response = await http.post(
      Uri.parse('https://3b927e53a5f9a7.lhr.life/api/appointments'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: '''
      {
        "appointment_date": "$appointmentDate",
        "doctor_id": $doctorId,
        "patient_name": "$patientName",
        "patient_contact": "$patientContact",
        "reason_for_visit": "$reasonForVisit",
        "notes": "$notes",
        "status": "$status"
      }
    ''',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Appointment confirmed with $selectedDoctor on $appointmentDate",
          ),
          backgroundColor: const Color(0xFFD4696E),
        ),
      );
      // Reset selections
      setState(() {
        selectedDate = null;
        selectedDoctor = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Failed to book appointment: ${response.body}",
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFEBEE),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'image/clinica2.png',
                  width: 200,
                ),
                CircleAvatar(
                  backgroundImage: const AssetImage('image/profile.png'),
                  radius: 25,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Book an Appointment",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Select Date",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 12.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          selectedDate != null
                              ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                              : "Tap to select a date",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Select Doctor",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: ListView.builder(
                        itemCount: doctors.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedDoctor = doctors[index];
                              });
                            },
                            child: Card(
                              color: selectedDoctor == doctors[index]
                                  ? const Color(0xFFFFEBEE)
                                  : const Color(0xFFF0F0F0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 2,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  doctors[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/viewappointment');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'View Your Appointment',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitAppointment,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFD4696E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Confirm Appointment',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
