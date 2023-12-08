import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String id;
  final String entity;
  final String name;
  final String organization;
  final String inn;
  final String status;

  Contact(
      {required this.id,
      required this.entity,
      required this.name,
      required this.organization,
      required this.inn,
      required this.status});

  @override
  List<Object?> get props => [id, entity, name, organization, inn, status];
}
