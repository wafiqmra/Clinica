class Appointment {
  final int id;
  final int doctorId;
  final String patientName;
  final String patientContact;
  final String appointmentDate; // Keep as String for initial parsing
  final String status;
  final String reasonForVisit;
  final String notes;

  Appointment({
    required this.id,
    required this.doctorId,
    required this.patientName,
    required this.patientContact,
    required this.appointmentDate,
    required this.status,
    required this.reasonForVisit,
    required this.notes,
  });

  // Factory method to create an Appointment from a Map
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      doctorId: json['doctor_id'],
      patientName: json['patient_name'],
      patientContact: json['patient_contact'],
      appointmentDate: json['appointment_date'], // Keep as String for initial parsing
      status: json['status'],
      reasonForVisit: json['reason_for_visit'],
      notes: json['notes'],
    );
  }

  // Method to parse the appointment date into a DateTime object
  DateTime get parsedAppointmentDate {
    try {
      return DateTime.parse(appointmentDate); // Parse to DateTime
    } catch (e) {
      print("Error parsing appointment date: $appointmentDate");
      return DateTime.now(); // Return the current date if parsing fails
    }
  }
}
