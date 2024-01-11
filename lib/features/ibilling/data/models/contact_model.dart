import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String entity;
  final String name;
  final String organization;
  final String inn;
  final String status;
  final DateTime date;
  final String number;
  bool isSaved;

  ContactModel({
    required this.entity,
    required this.name,
    required this.organization,
    required this.inn,
    required this.status,
    required this.date,
    required this.number,
    required this.isSaved,
  });

  // Factory constructor to create a ContactModel instance from a Json (e.g., Firestore document)
  factory ContactModel.fromJson(Map<String, dynamic> json, String docId) {
    return ContactModel(
      entity: json['entity'] ?? '',
      name: json['name'] ?? '',
      organization: json['organization'] ?? '',
      inn: json['inn'] ?? '',
      status: json['status'] ?? '',
      //date: (json['date'] as Timestamp).toDate(),
      date: (json['date'] as Timestamp).toDate(),
      number: docId,
      isSaved: json['isSaved'] ?? false,
    );
  }

  // Convert the ContactModel instance to a Json for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'entity': entity,
      'name': name,
      'organization': organization,
      'inn': inn,
      'status': status,
      'date': date,
      'number': number,
      'isSaved': isSaved,
    };
  }
}
