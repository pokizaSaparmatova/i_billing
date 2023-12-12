import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String entity;
  final String name;
  final String organization;
  final String inn;
  final String status;
  final Timestamp date;
  final String number;

  ContactModel(
      {required this.entity,
      required this.name,
      required this.organization,
      required this.inn,
      required this.status,
      required this.date,
        required this.number
      });

  // Factory constructor to create a ContactModel instance from a Json (e.g., Firestore document)
  factory ContactModel.fromJson(Map<String, dynamic> json,String docId) {
    return ContactModel(
        entity: json['entity'] ?? '',
        name: json['name'] ?? '',
        organization: json['organization'] ?? '',
        inn: json['inn'] ?? '',
        status: json['status'] ?? '',
        //date: (json['date'] as Timestamp).toDate(),
        date: (json['date'] as Timestamp),
      number: docId
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
      'number':number
    };
  }
}
