class Doctor {
  final int id;
  final String name;
  final String specialization;
  final String contact;
  final String availability;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.contact,
    required this.availability,
  });

  // Factory method to create a Doctor instance from JSON
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      specialization: json['specialization'],
      contact: json['contact'],
      availability: json['availability'],
    );
  }

  // Method to convert a Doctor instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'contact': contact,
      'availability': availability,
    };
  }
}
