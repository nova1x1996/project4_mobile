class Appointment {
  int id;
  String startTime;
  String endTime;
  String symptom;
  String typePayment;
  bool status;
  int price;
  DateTime date;
  DoctorDAO doctorId;

  Appointment(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.symptom,
      required this.typePayment,
      required this.price,
      required this.date,
      required this.doctorId,
      required this.status});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      startTime: json['starttime'],
      endTime: json['endtime'],
      symptom: json['symptom'],
      typePayment: json['typePayment'],
      status: json['status'],
      price: json['price'],
      date: DateTime.parse(json['date']),
      doctorId: DoctorDAO.fromJson(json['doctorId']),
    );
  }
}

class DoctorDAO {
  int id;
  String name;

  String password;
  String email;
  String address;
  bool gender;
  // Add other properties as needed

  DoctorDAO({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.address,
    required this.gender,
    // Add other properties as needed
  });

  factory DoctorDAO.fromJson(Map<String, dynamic> json) {
    return DoctorDAO(
      id: json['id'],
      name: json['name'],

      password: json['password'],
      email: json['email'],
      address: json['address'],
      gender: json['gender'],
      // Parse other properties as needed
    );
  }
}
