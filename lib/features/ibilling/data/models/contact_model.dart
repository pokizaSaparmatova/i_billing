class ContactModel {
  final String id;
  final String entity;
  final String name;
  final String organization;
  final String inn;
  final String status;

  ContactModel({
    required this.id,
    required this.entity,
    required this.name,
    required this.organization,
    required this.inn,
    required this.status,
  });

  // Factory constructor to create a ContactModel instance from a Json (e.g., Firestore document)
  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id'] ?? '',
      entity: json['entity']?? '',
      name: json['name'] ?? '',
      organization: json['organization'] ?? '',
      inn: json['inn']?? '',
      status: json['status']

    );
  }

  // Convert the ContactModel instance to a Json for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'entity':entity,
      'name': name,
      'organization': organization,
      'inn':inn,
      'status':status
    };
  }
}
